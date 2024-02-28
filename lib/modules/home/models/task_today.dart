import 'package:flutter/material.dart';
import 'package:timely/common/scheduling/tab_2_model.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';

class TaskToday {
  late final String name;
  late final TimeOfDay startTime;
  TimeOfDay? endTime;
  late final int tabNumber;
  late final dynamic model;

  TaskToday({
    required name,
    required startTime,
    required tabNumber,
    required model,
    endTime,
  });

  TaskToday.fromJson(Map json) {
    tabNumber = json["Tab Number"];
    name = json["Data"][tabNumber == 3 ? "Activity" : "Name"];

    List startTimeBreakup = json["Data"][tabNumber == 3 ? "Time" : "Start"]
        .split(":")
        .map((val) => int.parse(val))
        .toList();
    startTime =
        TimeOfDay(hour: startTimeBreakup[0], minute: startTimeBreakup[1]);

    if (tabNumber == 2) {
      endTime = Tab2Model.fromJson(json["Data"]).getEndTime();
    }

    switch (tabNumber) {
      case 2 || 6 || 7:
        model = Tab2Model.fromJson(json["Data"]);
        break;

      case 3:
        model = Tab3Model.fromJson(null, json["Data"]);
    }
  }

  toJson() {
    return {
      "Tab Number": tabNumber,
      "Data": model.toJson(),
    };
  }
}
