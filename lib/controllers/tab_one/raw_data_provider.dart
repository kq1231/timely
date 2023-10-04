import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';

final tabOneRawDataProvider = Provider.autoDispose<Map>((ref) {
  File tabOneFile = ref.read(dbFilesProvider).tabOneFile;
  return jsonDecode(tabOneFile.readAsStringSync()) as Map;
});
