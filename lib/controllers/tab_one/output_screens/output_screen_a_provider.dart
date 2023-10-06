import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';

final outputScreenAProvider = FutureProvider.autoDispose<Map>((ref) async {
  // Fake delay for awesomeness
  await Future.delayed(const Duration(milliseconds: 400));

  // First, read the file content
  Map tabOneData =
      jsonDecode(await ref.read(dbFilesProvider).tabOneFile.readAsString())
          as Map;

  // Fetch all the ratings...
  Map<String, Map<String, num>> ratingsData = {};

  for (String date in tabOneData.keys) {
    ratingsData[date] = {};
    for (String time_1 in tabOneData[date]["data"].keys) {
      num rating = 0;

      for (String typeName in tabOneData[date]["data"][time_1].keys) {
        rating +=
            tabOneData[date]["data"][time_1][typeName]["rating"].indexOf(1);
      }

      ratingsData[date]![time_1] = rating;
    }
  }

  return ratingsData;
  // eg.]
  // {
  //    "2023-09-12": [
  //          "9:00",
  //          "12:00"
  //                  ]
  // }
});
