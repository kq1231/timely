import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/list_struct/services/repo_service.dart';
import 'package:timely/modules/common/scheduling/mixins/filter_mixin.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/reusables.dart';

class SchedulingRepostioryNotifier<T>
    extends ListStructRepositoryService<Tab2Model> with FilterMixin {
  Future<List> getActivitiesForToday(Function modelizer, File file) async {
    // Get the models
    List models = await fetchModels(modelizer, file);
    return filterCurrentActivities(models);
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
