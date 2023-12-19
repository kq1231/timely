import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/reusables.dart';

final tab1Text1Provider = FutureProvider.autoDispose<String>((ref) async {
  // Read the tab1 file
  File file = (await ref.read(dbFilesProvider.future))[1]![0];

  // Extract the json
  Map content = jsonDecode(await file.readAsString());

  // Today's date
  String dateToday = DateFormat("yyyy-MM-dd").format(DateTime.now());

  // Get text_1 of today's date
  String text_1 = FMSModel.fromJson({dateToday: content[dateToday]}).text_1;

  return text_1;
});
