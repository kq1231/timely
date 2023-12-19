import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/reusables.dart';

final tab3Text1Provider =
    FutureProvider.autoDispose<List<Tab3Model>>((ref) async {
  // Get the file
  File file = (await ref.read(dbFilesProvider.future))[3]![0];

  // Extract the json
  Map content = jsonDecode(await file.readAsString());

  Map<String, List<Tab3Model>> models = {};

  for (String date in content.keys) {
    models[date] = [];
    for (Map modelData in content[date]) {
      models[date]!.add(Tab3Model.fromJson(date, modelData));
    }
  }

  String dateToday = DateFormat("yyyy-MM-dd").format(DateTime.now());

  if (models.keys.contains(dateToday)) {
    return models[dateToday]!;
  } else {
    return [];
  }
});
