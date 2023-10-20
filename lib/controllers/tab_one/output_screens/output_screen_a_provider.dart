import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';
import 'package:timely/models/color_rater.dart';

final outputScreenAProvider =
    FutureProvider.autoDispose<Map<String, List<ColorRater>>>((ref) async {
  // Fake delay for awesomeness
  await Future.delayed(const Duration(milliseconds: 400));

  File tabOneFile = (await ref.watch(dbFilesProvider.future)).tabOneFile;
  // First, read the file content
  Map tabOneData = jsonDecode(await tabOneFile.readAsString()) as Map;

  // Fetch all the ratings...
  Map<String, List<ColorRater>> ratingsData = {};

  for (String date in tabOneData.keys) {
    ratingsData[date] = [];
    for (String time_1 in tabOneData[date]["data"].keys) {
      List<String> text_2s = [];
      num rating = 0;
      for (String typeName in ["type_a", "type_b", "type_c"]) {
        text_2s.add(tabOneData[date]["data"][time_1][typeName]["comment"]);
        rating +=
            tabOneData[date]["data"][time_1][typeName]["rating"].indexOf(1);
      }

      print("$date $time_1 $rating");

      ratingsData[date]!.add(ColorRater(time_1, rating, text_2s));
    }
  }
  return ratingsData;
});
