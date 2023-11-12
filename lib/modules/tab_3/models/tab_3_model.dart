import 'package:flutter/material.dart';

class Tab3Model {
  String? date;
  TimeOfDay? time;
  String text_1 = "";
  int priority = 0;

  Tab3Model({
    required this.text_1,
    required this.priority,
    this.date,
    this.time,
  });

  Tab3Model.fromJson(this.date, Map json) {
    if (json["Time"] != null) {
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
    } else {
      String text_1 = json["Activity"];
      int priority = json["Priority"];

      this.text_1 = text_1;
      this.priority = priority;
    }
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

  Tab3Model copyWith(
      {String? date, String? text_1, int? priority, TimeOfDay? time}) {
    return Tab3Model(
        date: date ?? this.date,
        text_1: text_1 ?? this.text_1,
        time: time ?? this.time,
        priority: priority ?? this.priority);
  }
}
