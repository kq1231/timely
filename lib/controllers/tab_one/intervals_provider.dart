import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';
import 'package:timely/models/interval.dart';
import 'package:timely/models/type.dart';

final tabOneIntervalsProvider = FutureProvider<List<Interval>>((ref) async {
  List<Interval> accum = [];
  File tabOneFile = ref.read(dbFilesProvider).tabOneFile;

  Map tabOneData = jsonDecode(await tabOneFile.readAsString());

  // Get the intervals for every $date
  for (String date in tabOneData.keys) {
    Map intervals = tabOneData[date]["data"];

    // Create [Interval] objects
    for (String time_1 in intervals.keys) {
      String time_2 = intervals[time_1]["time_2"];
      Map typeAData = intervals[time_1]["type_a"];
      Map typeBData = intervals[time_1]["type_b"];
      Map typeCData = intervals[time_1]["type_c"];
      accum.add(
        Interval(
          date: date,
          time_1: time_1,
          time_2: time_2,
          types: [
            Type(
              typeCategory: TypeCategory.a,
              rating: typeAData["rating"],
              comment: typeAData["comment"],
            ),
            Type(
              typeCategory: TypeCategory.b,
              rating: typeBData["rating"],
              comment: typeBData["comment"],
            ),
            Type(
              typeCategory: TypeCategory.c,
              rating: typeCData["rating"],
              comment: typeCData["comment"],
            ),
          ],
        ),
      );
    }
  }
  return accum;
});
