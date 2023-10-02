import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbFilesProvider = Provider<Map<String, File>>((ref) {
  return {
    "tabOne": File("lib/data_pool/tab_1.json"),
  };
});
