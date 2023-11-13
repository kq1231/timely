import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/reusables.dart';

final tab3Text1Provider = FutureProvider.autoDispose<String>((ref) async {
  // Get the file
  File file = (await ref.read(dbFilesProvider.future)).tabThreeFile;

  // Extract the json
  Map content = jsonDecode(await file.readAsString());

  // Today's date
  String dateToday = DateFormat("yyyy-MM-dd").format(DateTime.now());

  // Get today's text_1
  try {
    String text_1 =
        Tab3Model.fromJson(dateToday, content[dateToday].last).text_1;
    return text_1;
  } catch (e) {
    print(e);
    return "Create tab 3 entry...";
  }
});
