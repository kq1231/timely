import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// Models
class DBFiles {
  final File tab1File;
  final File tab1ReFile;
  final File currentActivitiesFile;
  final File tab5File;
  final File tab3File;
  final File tab4File;
  final File tab2File;
  final File tab6File;
  final File tab7File;
  final File tab8File;
  final File tab10PendingFile;
  final File tab10CompletedFile;
  final File tab11PendingFile;
  final File tab11CompletedFile;

  DBFiles({
    required this.tab1File,
    required this.currentActivitiesFile,
    required this.tab1ReFile,
    required this.tab2File,
    required this.tab3File,
    required this.tab4File,
    required this.tab5File,
    required this.tab6File,
    required this.tab7File,
    required this.tab8File,
    required this.tab10PendingFile,
    required this.tab10CompletedFile,
    required this.tab11CompletedFile,
    required this.tab11PendingFile,
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

  File currentActivitiesFile = File('${docDir.path}/current_activities.json');
  File tab1File = File('${docDir.path}/tab_1.json');
  File tab1re = File('${docDir.path}/tab_1_re.json');
  File tabTwoFile = File('${docDir.path}/tab_2.json');
  File tab5File = File('${docDir.path}/tab_5.json');
  File tab3File = File('${docDir.path}/tab_3.json');
  File tab4File = File('${docDir.path}/tab_4.json');
  File tab6File = File('${docDir.path}/tab_6.json');
  File tab7File = File('${docDir.path}/tab_7.json');
  File tab8File = File('${docDir.path}/tab_8.json');
  File tab10PendingFile = File('${docDir.path}/tab_10_pending.json');
  File tab10CompletedFile = File('${docDir.path}/tab_10_completed.json');
  File tab11PendingFile = File('${docDir.path}/tab_11_pending.json');
  File tab11CompletedFile = File('${docDir.path}/tab_11_completed.json');

  if (!await currentActivitiesFile.exists()) {
    await currentActivitiesFile.writeAsString(
      "[]",
    );
  }

  if (!await tab1File.exists()) {
    await tab1File.writeAsString(
      "{}",
    );
  }

  if (!await tab1re.exists()) {
    await tab1re.writeAsString(
      "{}",
    );
  }

  if (!await tabTwoFile.exists()) {
    await tabTwoFile.writeAsString(
      "[]",
    );
  }

  if (!await tab3File.exists()) {
    await tab3File.writeAsString(
      "{}",
    );
  }
  if (!await tab4File.exists()) {
    await tab4File.writeAsString(
      "[]",
    );
  }
  if (!await tab5File.exists()) {
    await tab5File.writeAsString(
      "{}",
    );
  }

  if (!await tab6File.exists()) {
    await tab6File.writeAsString(
      "[]",
    );
  }

  if (!await tab7File.exists()) {
    await tab7File.writeAsString(
      "[]",
    );
  }

  if (!await tab8File.exists()) {
    await tab8File.writeAsString(
      "[]",
    );
  }

  if (!await tab10PendingFile.exists()) {
    await tab10PendingFile.writeAsString(
      "[]",
    );
  }

  if (!await tab10CompletedFile.exists()) {
    await tab10CompletedFile.writeAsString(
      "[]",
    );
  }

  if (!await tab11PendingFile.exists()) {
    await tab11PendingFile.writeAsString(
      "[]",
    );
  }

  if (!await tab11CompletedFile.exists()) {
    await tab11CompletedFile.writeAsString(
      "[]",
    );
  }

  return DBFiles(
    tab1File: tab1File,
    tab5File: tab5File,
    tab1ReFile: tab1re,
    tab3File: tab3File,
    tab4File: tab4File,
    tab2File: tabTwoFile,
    currentActivitiesFile: currentActivitiesFile,
    tab6File: tab6File,
    tab7File: tab7File,
    tab8File: tab8File,
    tab10PendingFile: tab10PendingFile,
    tab10CompletedFile: tab10CompletedFile,
    tab11PendingFile: tab11PendingFile,
    tab11CompletedFile: tab11CompletedFile,
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
