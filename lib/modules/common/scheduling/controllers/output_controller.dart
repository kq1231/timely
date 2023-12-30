import 'dart:async';
import 'dart:io';

import 'package:timely/modules/common/list_struct/controllers/output_controller.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/common/scheduling/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab2OutputNotifier<T> extends OutputNotifier<Tab2Model> {
  Tab2OutputNotifier({required int tabNumber})
      : super(
          tabNumber: tabNumber,
          modelizer: Tab2Model.fromJson,
          repositoryServiceProvider: schedulingRepositoryServiceProvider,
        );

  late File currentFile;

  @override
  FutureOr<List<Tab2Model>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[tabNumber]![1];
    currentFile = (await ref.read(dbFilesProvider.future))[tabNumber]!.last;

    await ref
        .read(schedulingRepositoryServiceProvider.notifier)
        .generateActivitiesForToday(tabNumber, modelizer, pendingFile);

    // Fetch the models from the db
    List<Tab2Model> models = await ref
        .read(schedulingRepositoryServiceProvider.notifier)
        .fetchModels(modelizer, currentFile);

    return models;
  }
}
