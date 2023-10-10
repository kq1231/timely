import 'package:flutter/material.dart';
import 'package:timely/models/type.dart';

class Interval {
  String date;
  TimeOfDay time_1;
  TimeOfDay time_2;
  List<Type> types;

  Interval({
    required this.date,
    required this.time_1,
    required this.time_2,
    required this.types,
  });
}
