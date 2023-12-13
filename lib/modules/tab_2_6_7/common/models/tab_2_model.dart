import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Tab2Model {
  String? uuid;
  String name = "";
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  Duration dur = const Duration();
  String? frequency = Frequency.daily;
  Basis? basis = Basis.day;
  DateTime startDate = DateTime.now();
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
    required this.startDate,
    required this.repetitions,
  });

  Tab2Model.fromJson(Map json) {
    name = json["Name"];
    uuid = json["ID"];
    List times = [
      json["Start"].split(":").map((val) => int.parse(val)).toList(),
      json["Duration"].split(":").map((val) => int.parse(val)).toList()
    ];

    startTime = TimeOfDay(hour: times[0][0], minute: times[0][1]);
    startDate = DateTime.parse(json["Start Date"]);
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

    return {
      "ID": uuid ?? const Uuid().v4(),
      "Name": name,
      "Start Date": startDate.toString().substring(0, 10),
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
  }

  List<int> calculateEndTime(Duration duration) {
    DateTime finalTime = DateTime(startDate.year, startDate.month,
            startDate.day, startTime.hour, startTime.minute)
        .add(dur);

    return [finalTime.hour, finalTime.minute];
  }

  Tab2Model copywith({
    String? name,
    String? uuid,
    TimeOfDay? startTime,
    Duration? endTime,
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
      dur: endTime ?? this.dur,
      frequency: frequency ?? this.frequency,
      basis: basis ?? this.basis,
      endDate: endDate ?? this.endDate,
      repetitions: repetitions ?? this.repetitions,
      every: every ?? this.every,
    );
  }
}

class Frequency {
  static String daily = "Daily";
  static String weekly = "Weekly";
  static String monthly = "Monthly";
  static String yearly = "Yearly";
}

enum Basis { date, day }