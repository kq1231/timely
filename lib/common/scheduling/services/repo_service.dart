import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/list_struct/services/repo_service.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/reusables.dart';

class SchedulingRepostioryNotifier<T>
    extends ListStructRepositoryService<Tab2Model> {
  Future<List> getActivitiesForToday(Function modelizer, File file) async {
    // Get the models
    List models = await fetchModels(modelizer, file);

    List filteredModels = [];
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
