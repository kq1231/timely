import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

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

final dbFilesProvider = FutureProvider<Map<int, List<File>>>((ref) async {
  Directory docDir = await getApplicationDocumentsDirectory();
  Map<int, List<File>> files = {};

  for (int i in List.generate(12, (index) => index + 1)) {
    File pending = File('${docDir.path}/tab_${i}_pending.json');
    File completed = File('${docDir.path}/tab_${i}_completed.json');

    for (File file in [pending, completed]) {
      await file.create();
      if ((await file.readAsString()).isEmpty) {
        if (![1, 3, 5].contains(i)) {
          await file.writeAsString("[]");
        } else {
          await file.writeAsString("{}");
        }
      }
    }

    files[i] = [
      pending,
      completed,
    ];
  }

  files[2] = [
    ...files[2]!,
    File('${docDir.path}/tab_2_current_activities.json')
  ];

  return files;
});

class TabIndex extends StateNotifier<int> {
  TabIndex() : super(12);

  void setIndex(int index) {
    state = index;
  }
}

final tabIndexProvider =
    StateNotifierProvider<TabIndex, int>((ref) => TabIndex());
