import 'package:flutter/material.dart';

class Tab3Model {
  String? date;
  TimeOfDay? time;
  String text_1 = "";
  int priority = 0;

  Tab3Model({
    required String text_1,
    required int priority,
    date,
    time,
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

  copyWith({date, text_1, priority, time}) {
    return Tab3Model(
        date: date ?? this.date,
        text_1: text_1 ?? this.text_1,
        time: time ?? this.time,
        priority: priority ?? this.priority);
  }
}
