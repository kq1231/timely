import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';
import 'package:timely/models/interval.dart';
import 'package:timely/models/type.dart';

class TabOneDataNotifier extends Notifier<List<Interval>> {
  @override
  List<Interval> build() {
    return [];
  }

  Future<void> fetch() async {
    File tabOneFile = ref.read(dbFilesProvider).tabOneFile;

    Map tabOneData = jsonDecode(await tabOneFile.readAsString());

    // Get the intervals for the $date
    Map intervals = tabOneData["02-10-2023"]["data"];

    // Create [Interval] objects
    for (String time_1 in intervals.keys) {
      Map typeAData = intervals[time_1]["type_a"];
      Map typeBData = intervals[time_1]["type_b"];
      Map typeCData = intervals[time_1]["type_c"];
      state.add(
        Interval(
          time_1: time_1,
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
}
