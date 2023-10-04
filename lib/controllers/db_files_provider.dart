import 'dart:io';
import 'package:timely/models/db_files.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbFilesProvider = Provider<DBFiles>((ref) {
  return DBFiles(
    tabOneFile: File("lib/data_pool/tab_1.json"),
  );
});
