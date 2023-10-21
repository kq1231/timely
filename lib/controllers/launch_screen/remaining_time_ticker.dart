import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/controllers/db_files_provider.dart';

final remainingTimeTickerProvider =
    StreamProvider.autoDispose<String>((ref) async* {
  File tabOneFile = (await ref.watch(dbFilesProvider.future)).tabOneFile;
  Map tabOneData = jsonDecode(await tabOneFile.readAsString());

  // First, get the time 2 of last interval of a particular date
  // ignore: prefer_interpolation_to_compose_strings
  String time_2String = "2023-10-21 " +
      tabOneData["2023-10-21"]["data"].values.toList().last["time_2"];
  DateTime time_2 = DateFormat("yyyy-MM-dd HH:mm").parse(time_2String);
  print(time_2);
  // Get the current time
  DateTime now = DateTime.now();

  Duration difference = time_2.difference(now);

  yield "${difference.inMinutes}:${difference.inSeconds % 60}";

  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    now = DateTime.now();
    difference = time_2.difference(now);
    yield "${difference.inMinutes}:${difference.inSeconds % 60}";
  }
});
