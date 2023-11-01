import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// Models
class DBFiles {
  final File tabOneFile;
  final File tabOneReFile;
  final File tabFiveFile;

  DBFiles(
      {required this.tabOneFile,
      required this.tabFiveFile,
      required this.tabOneReFile});
}

// Providers
final colorProvider = Provider<List<Color>>((ref) {
  return [
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red
  ];
});

final dbFilesProvider = FutureProvider<DBFiles>((ref) async {
  Directory docDir = await getApplicationDocumentsDirectory();
  File tabOneFile = File('${docDir.path}/tab_one.json');
  File tabOneReFile = File('${docDir.path}/tab_one_re.json');
  File tabFiveFile = File('${docDir.path}/tab_five.json');

  if (!await tabOneFile.exists()) {
    await tabOneFile.writeAsString("      {}");
  }

  if (!await tabFiveFile.exists()) {
    await tabFiveFile.writeAsString("{}");
  }

  if (!await tabOneReFile.exists()) {
    await tabOneReFile.writeAsString("{}");
  }

  return DBFiles(
      tabOneFile: tabOneFile,
      tabFiveFile: tabFiveFile,
      tabOneReFile: tabOneReFile);
});

class TabIndex extends StateNotifier<int> {
  TabIndex() : super(12);

  void setIndex(int index) {
    state = index;
  }
}

final tabIndexProvider =
    StateNotifierProvider<TabIndex, int>((ref) => TabIndex());
