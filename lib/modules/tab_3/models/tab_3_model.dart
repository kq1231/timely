import 'package:flutter/material.dart';

class Tab3Model {
  String? date;
  TimeOfDay? time;
  late String text_1;
  late int priority;

  Tab3Model({
    required String text_1,
    required int priority,
    date,
    time,
  });

  Tab3Model.fromJson(this.date, Map json) {
    List timeParts = json["Time"].split(":");
    TimeOfDay time = TimeOfDay(
      hour: int.parse(timeParts.first),
      minute: int.parse(timeParts.last),
    );
    String text_1 = json["Activity"];
    int priority = json["Priority"];

    this.time = time;
    this.text_1 = text_1;
    this.priority = priority;
  }

  Map toJson() {
    return {
      date: {
        "Activity": text_1,
        "Time": time,
        "Priority": priority,
      }
    };
  }
}
