import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/repos_and_controllers.dart';
import 'package:timely/common/scheduling/tab_2_model.dart';
import 'package:timely/reusables.dart';

class SchedulingRepostioryNotifier<T>
    extends ListStructRepositoryNotifier<Tab2Model> {
  Future<Map<String, List<Tab2Model>>> fetchActivities(
      Function modelizer, File file) async {
    // Get the models
    List models = await fetchModels(modelizer, file);

    List<Tab2Model> activitiesForToday = [];
    List<Tab2Model> upcomingActivities = [];

    for (final Tab2Model model in models) {
      DateTime nextDate = model.getNextOccurenceDateTime();
      if (DateTime(nextDate.year, nextDate.month, nextDate.day) ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        activitiesForToday.add(model);
      } else if (DateTime(nextDate.year, nextDate.month, nextDate.day).isAfter(
            DateTime.now(),
          ) &&
          nextDate != DateTime(0)) {
        upcomingActivities.add(model);
      }
    }

    activitiesForToday.sort((a, b) {
      return DateTime(0, 0, 0, a.startTime.hour, a.startTime.minute)
          .difference(
            DateTime(0, 0, 0, b.startTime.hour, b.startTime.minute),
          )
          .inSeconds;
    });

    upcomingActivities.sort((a, b) {
      return DateTime(0, 0, 0, a.startTime.hour, a.startTime.minute)
          .difference(
            DateTime(0, 0, 0, b.startTime.hour, b.startTime.minute),
          )
          .inSeconds;
    });

    return {
      "today": activitiesForToday,
      "upcoming": upcomingActivities,
    };
  }

  Future<List<Tab2Model>> getActivitiesForToday(
      Function modelizer, File file) async {
    // Get the models
    List models = await fetchModels(modelizer, file);

    List<Tab2Model> filteredModels = [];
    for (final Tab2Model model in models) {
      DateTime nextDate = model.getNextOccurenceDateTime();
      print(nextDate);
      if (DateTime(nextDate.year, nextDate.month, nextDate.day) ==
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        filteredModels.add(model);
      }
    }
    return filteredModels;
  }

  Future<void> generateActivitiesForToday(
      int tabNumber, Function modelizer) async {
    // Grab the files
    final currentActivitiesFile =
        (await ref.read(dbFilesProvider.future))[tabNumber]!.last;
    final pendingFile =
        (await ref.read(dbFilesProvider.future))[tabNumber]!.first;

    // Save to the file
    await currentActivitiesFile.writeAsString(
        jsonEncode(await getActivitiesForToday(modelizer, pendingFile)));
  }
}

final schedulingRepositoryServiceProvider =
    NotifierProvider<SchedulingRepostioryNotifier<Tab2Model>, void>(
        SchedulingRepostioryNotifier.new);
