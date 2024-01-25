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
  List<int> getOccurences(year, month) {
    List<int> occurences = [];
    int dayOfWeek = repetitions["DoW"][1];
    // Get all occurences of $day
    int firstOccurence = 0;
    int num = 0;
    while (true) {
      num++;
      if (DateTime(year, month, num).weekday == (dayOfWeek + 1)) {
        firstOccurence = num - 1; // As index.
        break;
      }
    }
    num = 0;
    while (true) {
      num++;
      if ((firstOccurence + 1) + (7 * num) < 31) {
        occurences.add((firstOccurence) + (7 * num));
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
    DateTime today = DateTime.now();
    DateTime start =
        startDate!.copyWith(hour: startTime.hour, minute: startTime.minute);
    DateTime nextDate = DateTime(0);

    // Assuming endDate is a DateTime object
    if (endDate != null) {
      if (endDate!.isBefore(today)) {
        return DateTime(0);
      }
    }

    switch (frequency) {
      case "Daily":
        int i = 0;
        bool found = false;
        while (!found) {
          nextDate = start.copyWith(
              day: start.day +
                  (((start.day - today.day) / every).floor() + 1) * every * i);
          print("NEXT DATE $nextDate");
          if (nextDate.isAfter(today)) {
            found = true;
          }

          i++;
        }
        return nextDate;

      case "Weekly":
        List<int> weekdayIndices = repetitions["Weekdays"].cast<int>();
        int i = 0;
        bool found = false;

        // Sort
        weekdayIndices.sort();

        while (!found && weekdayIndices.isNotEmpty) {
          for (int weekdayIndex in weekdayIndices) {
            nextDate = start.copyWith(
                day: start.day +
                    (((((start.day - today.day) * 7) / (every)).floor() + 1) *
                            (every * i) *
                            7 +
                        (weekdayIndex -
                            (today.weekday -
                                1)) // -1 as today.weekday does not return an index.
                    ));
            if (nextDate.isAfter(today)) {
              found = true;
              break;
            }
          }
          i++;
        }

        return nextDate;

      case "Monthly":
        // First, calculate the closest occurring month
        // Formula: Start + [floor((Current - Start) / n) + 1] * n, where n = Every
        // Check if any of the dates exist in that month
        // If none exist, then return the first date of the next closest month
        // We can check whether any of the dates exists in a particular month or
        // not by creating a DateTime object and then equating the month of this
        // new object and the nextDate.month.
        int i = 0;
        bool found = false;

        while (!found) {
          nextDate = start.copyWith(
            month: start.month +
                ((today.month - start.month) / every + 1).floor() * (every * i),
          ); // We are adding i because we want to go to the
          // 2nd next closest month if the 1st closest does not suffice.

          List<int> dates = [];
          if (basis == Basis.date) {
            dates = repetitions["Dates"].cast<int>();
            if (dates.isEmpty) {
              // Dates will be empty if none are selected.
              break;
            }
          } else if (basis == Basis.day) {
            try {
              int ordinalPosition = repetitions["DoW"][0];
              if (ordinalPosition != 5) {
                dates = [
                  getOccurences(nextDate.year, nextDate.month)[ordinalPosition]
                ];
              } else {
                dates = [
                  getOccurences(nextDate.year, nextDate.month).last
                ]; // OP of 5 means the last one.
              }
            } catch (e) {
              dates = [];
            }
          }

          // Sort the dates
          dates.sort();

          for (int date in dates) {
            date += 1; // Since it is an index.
            if (nextDate.copyWith(day: date).month == nextDate.month) {
              nextDate = nextDate.copyWith(day: date);
              // Now, also check whether the next date is after today's date.
              // If it is, well and good. Else, continue!
              if (nextDate.isAfter(today)) {
                found = true;
                break;
              } else {
                continue;
              }
            }
          }
          i++;
        }

        return nextDate;

      case "Yearly":
        List<int> months = repetitions["Months"].cast<int>();
        bool found = false;
        int i = 0;

        // Sort
        months.sort();

        while (!found && months.isNotEmpty) {
          nextDate = start.copyWith(
            year: start.year +
                (((today.year - start.year) / every).floor() + 1) * (every * i),
          );

          // Once we have the closest year, check for each month in $months
          // whether the date is after today or not.
          for (int month in months) {
            if (basis == Basis.day) {
              nextDate = nextDate.copyWith(month: month);

              List dates = [];

              try {
                int ordinalPosition = repetitions["DoW"][0];
                if (ordinalPosition != 5) {
                  dates = [
                    getOccurences(
                        nextDate.year, nextDate.month)[ordinalPosition]
                  ];
                } else {
                  dates = [
                    getOccurences(nextDate.year, nextDate.month).last
                  ]; // OP of 5 means the last one.
                }
              } catch (e) {
                dates = [];
              }

              for (int date in dates) {
                date++; // Since it is an index.
                if (nextDate.copyWith(month: month, day: date).isAfter(today)) {
                  found = true;
                  nextDate = nextDate.copyWith(month: month, day: date);
                  break;
                }
              }

              if (found) break; // Break out of the outer, month loop!
            } else if (basis == Basis.date) {
              if (nextDate.copyWith(month: month).isAfter(today)) {
                found = true;
                nextDate = nextDate.copyWith(month: month);
                break;
              }
            }
          }

          i++;
        }
        return nextDate;

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
              "Repeats on ${repetitions['Dates'].map((date) => date + 1).join(', ')} every $every ${every == 1 ? "month" : "months"}";
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
