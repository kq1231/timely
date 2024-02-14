import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/common/scheduling/services/repo_service.dart';
import 'package:timely/modules/tab_3/services/repo_service.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/reusables.dart';

// Get all entries from all tabs
// Separate them into timed, untimed, and non-scheduled
// The timed ones will be sorted
// For [Tab2Model]s, use the getNextOccurenceDateTime function
final todaysModelMapsProvider = FutureProvider.autoDispose<List>((ref) async {
  List modelMaps = [];

  // Fetch all models
  List datas = await Future.wait(
    [
      ref.read(schedulingRepositoryServiceProvider.notifier).fetchModels(
          Tab2Model.fromJson, ref.read(dbFilesProvider).requireValue[2]![0]),
      ref.read(tab3RepositoryServiceProvider.notifier).fetchModels(),
      ref.read(schedulingRepositoryServiceProvider.notifier).fetchModels(
          Tab2Model.fromJson, ref.read(dbFilesProvider).requireValue[6]![0]),
    ],
  );

  // Tabs 2, 6 and 7
  for (Tab2Model model in datas[0]) {
    var nextDateTime = model.getNextOccurenceDateTime();
    var now = DateTime.now();
    if ("${now.year} ${now.month} ${now.day}" ==
            "${nextDateTime.year} ${nextDateTime.month} ${nextDateTime.day}" &&
        !model.name!.contains("This is a sample entry that repeats daily.")) {
      modelMaps.add({
        "Tab Number": 2,
        "Data": model.toJson(),
      });
    }
  }

  for (Tab2Model model in datas.last) {
    var nextDateTime = model.getNextOccurenceDateTime();
    var now = DateTime.now();
    if ("${now.year} ${now.month} ${now.day}" ==
            "${nextDateTime.year} ${nextDateTime.month} ${nextDateTime.day}" &&
        !model.name!.contains("This is a sample entry that repeats daily.")) {
      modelMaps.add(
        {
          "Tab Number": 6,
          "Data": model.toJson(),
        },
      );
    }
  }

  // Tab 3
  Map tab3Data = datas[1];
  String dateToday = DateFormat("yyyy-MM-dd").format(DateTime.now());

  for (String date in tab3Data["scheduled"].keys) {
    if (date == dateToday) {
      for (Tab3Model model in tab3Data["scheduled"][date]) {
        if (!model.text_1.contains("This is a sample entry.")) {
          modelMaps.add({
            "Tab Number": 3,
            "Data": model.toJson(),
          });
        }
      }
    }
  }

  return modelMaps;
});
