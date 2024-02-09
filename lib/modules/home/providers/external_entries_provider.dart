import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/common/scheduling/services/repo_service.dart';
import 'package:timely/modules/tab_1/repositories/repo.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/modules/tab_10/services/repo_service.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';
import 'package:timely/modules/tab_12/services/repo_service.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/services/repo_service.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';
import 'package:timely/modules/tab_5/repositories/tab_5_repo.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';
import 'package:timely/modules/tab_8/services/repo_service.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';
import 'package:timely/reusables.dart';

// Get all entries from all tabs
// Separate them into timed, untimed, and non-scheduled
// The timed ones will be sorted
// For [Tab2Model]s, use the getNextOccurenceDateTime function
final externalEntriesProvider = FutureProvider<Map<String, List>>((ref) async {
  Map<String, List> entries = {
    "timed": [],
    "untimed": [],
    "non-scheduled": [],
  };

  // Fetch all models
  List datas = await Future.wait(
    [
      ref.read(tab1RepositoryProvider.notifier).fetchFMSModels(),
      ref.read(schedulingRepositoryServiceProvider.notifier).fetchModels(
          Tab2Model.fromJson, ref.read(dbFilesProvider).requireValue[2]![0]),
      ref
          .read(tab3RepositoryServiceProvider.notifier)
          .fetchModels(ref.read(dbFilesProvider).requireValue[3]![0]),
      ref.read(tab4RepositoryProvider.notifier).fetchTab4Models(),
      ref.read(tab5RepositoryProvider.notifier).fetchSPWModels(),
      ref.read(schedulingRepositoryServiceProvider.notifier).fetchModels(
          Tab2Model.fromJson, ref.read(dbFilesProvider).requireValue[6]![0]),
      ref.read(schedulingRepositoryServiceProvider.notifier).fetchModels(
          Tab2Model.fromJson, ref.read(dbFilesProvider).requireValue[7]![0]),
      ref.read(tab8RepositoryServiceProvider.notifier).fetchModels(
          Tab8Model.fromJson, ref.read(dbFilesProvider).requireValue[8]![0]),
      ref
          .read(tab9RepositoryServiceProvider.notifier)
          .fetchEntriesAndSubEntries(
              ref.read(dbFilesProvider).requireValue[9]![0],
              Tab9EntryModel.fromJson,
              Tab9SubEntryModel.fromJson),
      ref.read(tab10RepositoryServiceProvider.notifier).fetchModels(
          Tab10Model.fromJson, ref.read(dbFilesProvider).requireValue[10]![0]),
      ref
          .read(tab12RepositoryServiceProvider.notifier)
          .fetchEntriesAndSubEntries(
              ref.read(dbFilesProvider).requireValue[12]![0],
              Tab12EntryModel.fromJson,
              Tab12SubEntryModel.fromJson),
    ],
  );

  // Tabs 2, 6 and 7
  for (Tab2Model model in datas[2 - 1]) {
    var nextDateTime = model.getNextOccurenceDateTime();
    var now = DateTime.now();
    if ("${now.year} ${now.month} ${now.day}" ==
            "${nextDateTime.year} ${nextDateTime.month} ${nextDateTime.day}" &&
        !model.name!.contains("This is a sample entry that repeats daily.")) {
      entries["timed"]!.add(
        [
          2,
          model, // Tab number
          [
            model.name, // Name
            TimeOfDay.fromDateTime(nextDateTime), // Time
          ],
        ],
      );
    }
  }

  for (Tab2Model model in datas[6 - 1]) {
    var nextDateTime = model.getNextOccurenceDateTime();
    var now = DateTime.now();
    if ("${now.year} ${now.month} ${now.day}" ==
            "${nextDateTime.year} ${nextDateTime.month} ${nextDateTime.day}" &&
        !model.name!.contains("This is a sample entry that repeats daily.")) {
      entries["timed"]!.add(
        [
          6,
          model, // Tab number
          [
            model.name, // Name
            TimeOfDay.fromDateTime(nextDateTime), // Time
          ],
        ],
      );
    }
  }

  for (Tab2Model model in datas[7 - 1]) {
    var nextDateTime = model.getNextOccurenceDateTime();
    var now = DateTime.now();
    if ("${now.year} ${now.month} ${now.day}" ==
            "${nextDateTime.year} ${nextDateTime.month} ${nextDateTime.day}" &&
        !model.name!.contains("This is a sample entry that repeats daily.")) {
      entries["timed"]!.add(
        [
          7,
          model, // Tab number
          [
            model.name, // Name
            TimeOfDay.fromDateTime(nextDateTime), // Time
          ],
        ],
      );
    }
  }

  // Tab 3
  Map tab3Data = datas[3 - 1];
  String dateToday = DateFormat("yyyy-MM-dd").format(DateTime.now());

  for (String date in tab3Data.keys) {
    if (date == dateToday) {
      for (Tab3Model model in tab3Data[date]) {
        if (!model.text_1
            .contains("This is a sample entry.")) {
          entries["timed"]!.add(
            [
              3,
              model, // Tab number
              [
                model.text_1, // Name
                model.time, // Time
              ],
            ],
          );
        }
      }
    }
  }

  // Sorting
  entries["timed"]!.sort((a, b) {
    TimeOfDay time1 = a[2][1];
    TimeOfDay time2 = b[2][1];

    return DateTime(0, 0, 0, time1.hour, time1.minute)
        .compareTo(DateTime(0, 0, 0, time2.hour, time2.hour));
  });

  return entries;
});
