import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/public_providers/db_files_provider.dart';

final outputScreenCProvider =
    FutureProvider.autoDispose<Map<String, String>>((ref) async {
  // Fake delay for awesomeness
  await Future.delayed(const Duration(milliseconds: 400));

  File tabOneFile = (await ref.watch(dbFilesProvider.future)).tabOneFile;
  // First, read the file content
  Map tabOneData = jsonDecode(await tabOneFile.readAsString()) as Map;

  // Extract the text_1s
  Map<String, String> text_1s = {};
  for (String date in tabOneData.keys) {
    text_1s[date] = (tabOneData[date]["text_1"]);
  }

  print("DONE");

  return text_1s;
});
