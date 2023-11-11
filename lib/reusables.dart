import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// Models
class DBFiles {
  final File tabOneFile;
  final File tabOneReFile;
  final File tabFiveFile;
  final File tabThreeFile;
  final File tabFourFile;

  DBFiles({
    required this.tabOneFile,
    required this.tabFiveFile,
    required this.tabOneReFile,
    required this.tabThreeFile,
    required this.tabFourFile,
  });
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
  File tab1File = File('${docDir.path}/tab_1.json');
  File tab2File = File('${docDir.path}/tab_1_re.json');
  File tab5File = File('${docDir.path}/tab_5.json');
  File tab3File = File('${docDir.path}/tab_3.json');
  File tab4File = File('${docDir.path}/tab_4.json');

  if (!await tab1File.exists()) {
    await tab1File.writeAsString("      {}");
  }

  if (!await tab5File.exists()) {
    await tab5File.writeAsString("{}");
  }

  if (!await tab2File.exists()) {
    await tab2File.writeAsString("{}");
  }

  if (!await tab3File.exists()) {
    await tab3File.writeAsString("{}");
  }

  if (!await tab4File.exists()) {
    await tab4File.writeAsString("[]");
  }

  return DBFiles(
    tabOneFile: tab1File,
    tabFiveFile: tab5File,
    tabOneReFile: tab2File,
    tabThreeFile: tab3File,
    tabFourFile: tab4File,
  );
});

class TabIndex extends StateNotifier<int> {
  TabIndex() : super(12);

  void setIndex(int index) {
    state = index;
  }
}

final tabIndexProvider =
    StateNotifierProvider<TabIndex, int>((ref) => TabIndex());
