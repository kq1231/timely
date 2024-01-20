import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Tab2Model {
  String? uuid;
  String? name;
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  Duration dur = const Duration();
  String? frequency = Frequency.daily;
  Basis? basis = Basis.day;
  DateTime? startDate = DateTime.now();
  DateTime? endDate;
  Map repetitions = {};
  int every = 1;

  Tab2Model({
    this.uuid,
    required this.name,
    required this.startTime,
    required this.dur,
    this.frequency,
    this.basis,
    this.endDate,
    required this.every,
    this.startDate,
    required this.repetitions,
  });

  Tab2Model.fromJson(Map json) {
    if (json.containsKey("Start Date") || json.containsKey("Name")) {
      startDate = DateTime.parse(json["Start Date"]);
      name = json["Name"];
    }
    uuid = json["ID"];
    List times = [
      json["Start"].split(":").map((val) => int.parse(val)).toList(),
      json["Duration"].split(":").map((val) => int.parse(val)).toList()
    ];

    startTime = TimeOfDay(hour: times[0][0], minute: times[0][1]);
    dur = Duration(hours: times[1][0], minutes: times[1][1]);
    every = json["Every"];
    frequency = json["Frequency"];
    repetitions = json["Repeat"] ?? {};
    basis = json["Basis"] != null
        ? json["Basis"] == "Day"
            ? Basis.day
            : Basis.date
        : null;
    endDate = json["Ends"] != "Never" ? DateTime.parse(json["Ends"]) : null;
  }

  Map toJson() {
    // Convert last to -1
    if (basis == Basis.day &&
        ![Frequency.weekly, Frequency.daily].contains(frequency)) {
      if (repetitions["DoW"].first == 5) {
        repetitions["DoW"][0] = -1;
      }
    }

    Map json = {
      "ID": uuid ?? const Uuid().v4(),
      "Start": [startTime.hour, startTime.minute].join(":"),
      "Duration": [dur.inHours, dur.inMinutes % 60].join(":"),
      "Frequency": frequency,
      "Basis": basis != null
          ? basis == Basis.date
              ? "Date"
              : "Day"
          : null,
      "Repeat": frequency != null ? repetitions : null,
      "Every": every,
      "Ends":
          endDate == null ? "Never" : DateFormat("yyyy-MM-dd").format(endDate!)
    };

    if (startDate != null) {
      json["Start Date"] = startDate.toString().substring(0, 10);
    }

    if (name != null) {
      json["Name"] = name;
    }

    return json;
  }

  List<int> calculateEndTime(Duration duration) {
    DateTime finalTime = DateTime(startDate!.year, startDate!.month,
            startDate!.day, startTime.hour, startTime.minute)
        .add(dur);

    return [finalTime.hour, finalTime.minute];
  }

  TimeOfDay getEndTime() {
    List finalTime = calculateEndTime(dur);
    return TimeOfDay(hour: finalTime[0], minute: finalTime[1]);
  }

  Tab2Model copyWith({
    String? name,
    String? uuid,
    TimeOfDay? startTime,
    Duration? dur,
    String? frequency,
    Map? repetitions,
    int? every,
    Basis? basis,
    DateTime? endDate,
    DateTime? startDate,
  }) {
    return Tab2Model(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      dur: dur ?? this.dur,
      frequency: frequency ?? this.frequency,
      basis: basis ?? this.basis,
      endDate: endDate ?? this.endDate,
      repetitions: repetitions ?? this.repetitions,
      every: every ?? this.every,
    );
  }

  // The following functions calculate the next closest date on which
  // the task is set to occur.
  List<int> getOccurences() {
    List<int> occurences = [];
    int dayOfWeek = repetitions["DoW"][1];
    // Get all occurences of $day
    int firstOccurence = 0;
    int num = 0;
    while (true) {
      num++;
      if (DateTime(DateTime.now().year, DateTime.now().month, num).weekday ==
          (dayOfWeek + 1)) {
        firstOccurence = num - 1; // As index.
        break;
      }
    }
    num = 0;
    while (true) {
      num++;
      if ((firstOccurence + 1) + (7 * num) < 31) {
        occurences.add((firstOccurence + 1) + (7 * num));
      } else {
        break;
      }
    }
    return [firstOccurence, ...occurences];
  }

  bool isNthDayOfWeek(DateTime date, int dayOfWeek, int ordinalPosition) {
    int count = 0;
    for (int i = 1; i <= date.day; i++) {
      if (DateTime(date.year, date.month, i).weekday == dayOfWeek) {
        count++;
      }
    }
    return count == ordinalPosition;
  }

  DateTime getNthDayOfWeekInMonth(
      DateTime date, int dayOfWeek, int ordinalPosition) {
    int count = 0;
    for (int i = 1; i <= 31; i++) {
      try {
        DateTime currentDate = DateTime(date.year, date.month, i);
        if (currentDate.weekday == dayOfWeek) {
          count++;
          if (count == ordinalPosition) {
            return currentDate;
          }
        }
      } catch (e) {
        break;
      }
    }
    return date;
  }

  DateTime getNextOccurenceDateTime() {
    TimeOfDay endTime = getEndTime();
    DateTime dateToday = DateTime.now();

    // Assuming endDate is a DateTime object
    if (endDate!.isBefore(dateToday)) {
      return DateTime(0);
    }

    switch (frequency) {
      case "Daily":
        return dateToday
            .add(
                Duration(days: dateToday.difference(startDate!).inDays % every))
            .copyWith(hour: endTime.hour, minute: endTime.minute);

      case "Weekly":
        int firstDayIndex = startDate!.copyWith(day: 1).weekday - 1;
        List weekdays = repetitions["Weekdays"];
        weekdays.sort();
        List filteredWeekdays = weekdays
            .where((element) => element >= (dateToday.weekday - 1))
            .toList();
        int weekNumber =
            ((dateToday.difference(startDate!).inDays + 1 + firstDayIndex) / 7)
                    .ceil() -
                1;
        return dateToday
            .add(Duration(
                days: (filteredWeekdays[0] - (dateToday.weekday - 1)) +
                    (weekNumber % every) * 7))
            .copyWith(hour: endTime.hour, minute: endTime.minute);

      case "Monthly":
        DateTime nextDate = startDate!;
        List dates = basis == Basis.date
            ? repetitions["Dates"]
            : [getOccurences()[repetitions["DoW"][0]]];

        while (nextDate.isBefore(dateToday) ||
            nextDate.day !=
                dates.firstWhere((date) => date >= nextDate.day,
                    orElse: () => dates[0])) {
          nextDate =
              DateTime(nextDate.year, nextDate.month + every - 1, nextDate.day);
          if (nextDate.day > dates.last) {
            nextDate =
                DateTime(nextDate.year, nextDate.month + every - 1, dates[0]);
          } else {
            nextDate = DateTime(nextDate.year, nextDate.month,
                dates.firstWhere((date) => date >= nextDate.day));
          }
        }
        return nextDate.copyWith(hour: endTime.hour, minute: endTime.minute);

      case "Yearly":
        List<int> months = repetitions["Months"];
        if (basis == Basis.date) {
          DateTime nextDate =
              DateTime(startDate!.year, months.first, startDate!.day);
          while (nextDate.isBefore(dateToday) ||
              !months.contains(nextDate.month)) {
            nextDate =
                DateTime(nextDate.year + every, nextDate.month, startDate!.day);
            if (!months.contains(nextDate.month)) {
              nextDate = DateTime(
                  nextDate.year,
                  months.firstWhere((month) => month > nextDate.month,
                      orElse: () => months[0]),
                  nextDate.day);
            }
          }
          return nextDate;
        } else {
          DateTime nextDate = DateTime(startDate!.year, months.first, 1);
          int ordinalPosition = repetitions["Dow"][0];
          int dayOfWeek = repetitions["DoW"][1];
          while (nextDate.isBefore(dateToday) ||
              !months.contains(nextDate.month) ||
              !isNthDayOfWeek(nextDate, dayOfWeek, ordinalPosition)) {
            nextDate = DateTime(nextDate.year + every, nextDate.month, 1);
            if (!months.contains(nextDate.month)) {
              nextDate = DateTime(
                  nextDate.year,
                  months.firstWhere((month) => month > nextDate.month,
                      orElse: () => months[0]),
                  1);
            }
            nextDate =
                getNthDayOfWeekInMonth(nextDate, dayOfWeek, ordinalPosition);
          }
          return nextDate;
        }
      default:
        return DateTime(0).copyWith(hour: endTime.hour, minute: endTime.minute);
    }
  }

  String getRepetitionSummary() {
    List sliderNames = [
      ["First", "Second", "Third", "Fourth", "Fifth", "Last"],
      [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ]
    ];
    List monthNames =
        "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec".split(",");

    String repetitionSummary = "";

    switch (frequency) {
      case "Monthly":
        if (basis == Basis.date) {
          repetitionSummary =
              "Repeats on ${repetitions['Dates'].join(', ')} every $every months";
        } else {
          repetitionSummary =
              "Repeats on the ${sliderNames[0][repetitions["DoW"][0]].toLowerCase()} ${sliderNames[1][repetitions["DoW"][1]]} every $every months";
        }
        break;
      case "Yearly":
        if (basis == Basis.date || basis == null) {
          repetitionSummary =
              "Repeats in ${repetitions["Months"].map((val) => monthNames[val - 1]).toList().join(", ")} every $every years";
        } else {
          repetitionSummary =
              "Repeats on the ${sliderNames[0][repetitions["DoW"][0]].toLowerCase()} ${sliderNames[1][repetitions["DoW"][1]]} of ${repetitions["Months"].map((val) => monthNames[val - 1]).toList().join(", ")} every $every years";
        }
        break;
      case "Weekly":
        repetitionSummary =
            "Repeats on ${repetitions["Weekdays"].map((val) => sliderNames[1][val]).toList().join(", ")} every $every weeks";
      case "Daily":
        repetitionSummary = "Repeats daily";
    }

    return repetitionSummary;
  }
}

class Frequency {
  static String daily = "Daily";
  static String weekly = "Weekly";
  static String monthly = "Monthly";
  static String yearly = "Yearly";
}

enum Basis { date, day }
