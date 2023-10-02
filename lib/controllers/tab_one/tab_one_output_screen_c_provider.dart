import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';

final tabOneOutputScreenCProvider =
    FutureProvider.autoDispose<Map>((ref) async {
  // Simulate a delay for awesomeness
  await Future.delayed(const Duration(seconds: 1));

  // Read the file
  Map tabOneData =
      jsonDecode(await ref.read(dbFilesProvider)["tabOne"]!.readAsString())
          as Map;

  Map text_1Data = {};

  // Add the dates
  for (String date in tabOneData.keys) {
    text_1Data.addAll({date: {}});
  }

  for (String date in text_1Data.keys) {
    for (String type in ["a", "b", "c"]) {
      text_1Data[date]
          .addAll({"type_$type": tabOneData[date]["type_$type"]["text_1"]});
    }
  }

  return text_1Data;
});
