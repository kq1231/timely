import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// Models
class DBFiles {
  final File tab1File;
  final File tab1ReFile;
  final File tab5File;
  final File tab3File;
  final File tab4File;
  final File tab2File;
  final File tab2CurrentActivitiesFile;

  DBFiles(
      {required this.tab1File,
      required this.tab5File,
      required this.tab1ReFile,
      required this.tab3File,
      required this.tab4File,
      required this.tab2File,
      required this.tab2CurrentActivitiesFile});
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
  File tabTwoFile = File('${docDir.path}/tab_2.json');
  File tab5File = File('${docDir.path}/tab_5.json');
  File tab3File = File('${docDir.path}/tab_3.json');
  File tab4File = File('${docDir.path}/tab_4.json');
  File tab2CurrentActivitiesFile =
      File('${docDir.path}/tab_2_current_activities.json');

  if (!await tab1File.exists()) {
    await tab1File.writeAsString("{}");
  }

  if (!await tab5File.exists()) {
    await tab5File.writeAsString("{}");
  }

  if (!await tab2File.exists()) {
    await tab2File.writeAsString("{}");
  }

  if (!await tabTwoFile.exists()) {
    await tabTwoFile.writeAsString("[]");
  }

  if (!await tab3File.exists()) {
    await tab3File.writeAsString("{}");
  }

  if (!await tab4File.exists()) {
    await tab4File.writeAsString("[]");
  }

  if (!await tab2CurrentActivitiesFile.exists()) {
    await tab2CurrentActivitiesFile.writeAsString("[]");
  }

  return DBFiles(
    tab1File: tab1File,
    tab5File: tab5File,
    tab1ReFile: tab2File,
    tab3File: tab3File,
    tab4File: tab4File,
    tab2File: tabTwoFile,
    tab2CurrentActivitiesFile: tab2CurrentActivitiesFile,
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
