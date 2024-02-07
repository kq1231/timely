import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/common/scheduling/services/repo_service.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/repositories/repo.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/modules/tab_10/services/repo_service.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';
import 'package:timely/modules/tab_11/services/repo_service.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';
import 'package:timely/modules/tab_12/services/repo_service.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/services/repo_service.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';
import 'package:timely/modules/tab_5/models/spw.dart';
import 'package:timely/modules/tab_5/repositories/tab_5_repo.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';
import 'package:timely/modules/tab_8/services/repo_service.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';

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

final dbFilesProvider = FutureProvider<Map<int, List<File>>>(
  (ref) async {
    Directory docDir = await getApplicationDocumentsDirectory();
    Map<int, List<File>> files = {};

    void createDefaultEntry(int tabNumber) {
      File file = File('${docDir.path}/tab_${tabNumber}_pending.json');

      switch (tabNumber) {
        case 1:
          ref.read(tab1RepositoryProvider.notifier).writeFMSModel(
                FMSModel(
                  date: DateTime.now(),
                  fScore: Duration.zero,
                  mScore: Duration.zero,
                  sScore: Duration.zero,
                  fStatus: 0,
                  mStatus: 0,
                  sStatus: 0,
                  text_1: "",
                  nextUpdateTime: TimeOfDay.now(),
                ),
              );
          break;

        case 2 || 6 || 7:
          ref.read(schedulingRepositoryServiceProvider.notifier).writeModel(
                Tab2Model(
                  name: "This is a sample entry that repeats daily.",
                  startTime: TimeOfDay.now(),
                  startDate: DateTime.now(),
                  dur: Duration.zero,
                  every: 1,
                  basis: Basis.day,
                  frequency: Frequency.daily,
                  repetitions: {},
                ),
                file,
              );
          break;

        case 3:
          ref.read(tab3RepositoryServiceProvider.notifier).writeModel(
                Tab3Model(
                  text_1: "This is a sample entry.",
                  priority: 0,
                  time: TimeOfDay.now(),
                  date: DateTime.now(),
                ),
                file,
              );

        case 4:
          ref.read(tab4RepositoryProvider.notifier).writeModel(
                Tab3Model(text_1: "This is a sample entry.", priority: 0),
              );

        case 5:
          ref.read(tab5RepositoryProvider.notifier).writeSPWModel(
                SPWModel(
                  date: DateTime.now(),
                  sScore: 0,
                  pScore: 0,
                  wScore: 0,
                ),
              );

        case 8:
          ref.read(tab8RepositoryServiceProvider.notifier).writeModel(
                Tab8Model(
                    date: DateTime.now(),
                    title: "This is a sample entry.",
                    description: "This is a sample description.",
                    lsj: 0,
                    hml: 0),
                file,
              );

        case 9:
          ref.read(tab9RepositoryServiceProvider.notifier).writeEntry(
            const Tab9EntryModel(
                condition: "A sample condition.",
                criticality: 0,
                care: "A sample care.",
                lessonLearnt: "A sample lesson."),
            file,
            [
              Tab9SubEntryModel(
                  date: DateTime.now(),
                  time: "00:00",
                  task: "A sample task.",
                  description: "A sample descrption."),
            ],
          );

        case 10:
          ref.read(tab10RepositoryServiceProvider.notifier).writeModel(
                Tab10Model(
                  date: DateTime.now(),
                  text_1: "Some sample text.",
                  amount: 100.0,
                  option: 1,
                  isComplete: false,
                ),
                file,
              );

        case 11:
          ref.read(tab11RepositoryServiceProvider.notifier).writeModel(
                Tab11Model(
                  item: "A sample item that is not urgent.",
                  qty: 10,
                  urgent: false,
                ),
                file,
              );

        case 12:
          ref.read(tab12RepositoryServiceProvider.notifier).writeEntry(
            Tab12EntryModel(
              activity: "A sample activity",
              objective: 'An objective.',
              tab2Model: Tab2Model(
                name: "This is a sample entry that repeats daily.",
                startTime: TimeOfDay.now(),
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                dur: Duration.zero,
                every: 1,
                basis: Basis.day,
                frequency: Frequency.daily,
                repetitions: {},
              ),
              importance: 1,
            ),
            file,
            [
              Tab12SubEntryModel(
                nextTask: "A sample task.",
                date: DateTime.now(),
              ),
            ],
          );
      }
    }

    for (int tabNumber in List.generate(12, (index) => index + 1)) {
      File pending = File('${docDir.path}/tab_${tabNumber}_pending.json');
      File completed = File('${docDir.path}/tab_${tabNumber}_completed.json');

      var temp = 0;
      for (File file in [pending, completed]) {
        await file.create();
        if ((await file.readAsString()).isEmpty) {
          if (![1, 3, 5].contains(tabNumber)) {
            await file.writeAsString("[]");
          } else {
            await file.writeAsString("{}");
          }

          if (temp == 0) {
            createDefaultEntry(tabNumber);
          }
        }
        temp++;
      }

      if ([2, 6, 7].contains(tabNumber)) {
        File current =
            File('${docDir.path}/tab_${tabNumber}_current_activities.json');
        await current.create();
        if ((await current.readAsString()).isEmpty) {
          await current.writeAsString("[]");
        }
      }

      files[tabNumber] = [
        pending,
        completed,
      ];
    }

    for (int i in [2, 6, 7]) {
      files[i] = [
        ...files[i]!,
        File('${docDir.path}/tab_${i}_current_activities.json')
      ];
    }

    return files;
  },
);

class TabIndex extends StateNotifier<int> {
  TabIndex() : super(12);

  void setIndex(int index) {
    state = index;
  }
}

final tabIndexProvider =
    StateNotifierProvider<TabIndex, int>((ref) => TabIndex());
