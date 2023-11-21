import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tab2Model {
  String name = "";
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);
  String frequency = Frequency.daily;
  Basis basis = Basis.day;
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  List repetitions = [];

  Tab2Model({
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.frequency,
    required this.basis,
    this.endDate,
    required this.startDate,
    required this.repetitions,
  });

  Tab2Model.fromJson(Map json) {
    name = json["Name"];

    List times = [
      json["Start"].split(":").map((val) => int.parse(val)).toList(),
      json["End"].split(":").map((val) => int.parse(val)).toList()
    ];

    startTime = TimeOfDay(hour: times[0][0], minute: times[0][1]);
    startDate = json["Start Date"];
    endTime = TimeOfDay(hour: times[1][0], minute: times[1][1]);
    frequency = json["Frequency"];
    repetitions = json["Repeats"];
    endDate = DateTime.parse(json["Ends"]);
  }

  Map toJson() {
    return {
      "Name": name,
      "Start": [startTime.hour, startTime.minute].join(":"),
      "End": [endTime.hour, endTime.minute].join(":"),
      "Frequency": frequency,
      "Start Date": startDate.toString().substring(0, 10),
      "Basis": basis == Basis.date ? "Date" : "Day",
      "Repeat": repetitions,
      "Ends":
          endDate == null ? "Never" : DateFormat("dd-MM-yyyy").format(endDate!)
    };
  }

  Tab2Model copywith({
    String? name,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? frequency,
    List? repetitions,
    Basis? basis,
    DateTime? endDate,
    DateTime? startDate,
  }) {
    return Tab2Model(
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        frequency: frequency ?? this.frequency,
        basis: basis ?? this.basis,
        endDate: endDate ?? this.endDate,
        repetitions: repetitions ?? this.repetitions);
  }
}

class Frequency {
  static String daily = "Daily";
  static String weekly = "Weekly";
  static String monthly = "Monthly";
  static String yearly = "Yearly";
}

enum Basis { date, day }
