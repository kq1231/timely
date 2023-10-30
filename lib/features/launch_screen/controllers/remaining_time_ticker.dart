import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/public_providers/db_files_provider.dart';

final remainingTimeTickerProvider =
    StreamProvider.autoDispose<String>((ref) async* {
  File tabOneFile = (await ref.watch(dbFilesProvider.future)).tabOneFile;
  Map tabOneData = jsonDecode(await tabOneFile.readAsString());

  // First, check if today's date exists in the database
  String todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  if (!tabOneData.containsKey(todayDate)) {
    yield "No Activity Created";
    return;
  }

  Map intervals = tabOneData[todayDate]["data"];
  DateTime now = DateTime.now();
  bool _isFound = false;

  for (var time1 in intervals.keys) {
    String time2String = intervals[time1]["time_2"];
    DateTime time1DateTime = DateFormat("HH:mm").parse(time1);
    DateTime time2 =
        DateFormat("yyyy-MM-dd HH:mm").parse("$todayDate $time2String");
    DateTime time1DateTimeFull = DateTime(
        now.year, now.month, now.day, time1DateTime.hour, time1DateTime.minute);
    print(time1DateTimeFull);
    print(time2);
    if (now.isAfter(time1DateTimeFull) && now.isBefore(time2)) {
      _isFound = true;
      while (true) {
        await Future.delayed(const Duration(seconds: 1));
        print("HELLO");
        Duration difference = time2.difference(now);
        yield "${difference.inHours}:${difference.inMinutes % 60}:${difference.inSeconds % 60}";
      }
    }
  }
  if (!_isFound) {
    yield "No Current Activity";
  }
});
