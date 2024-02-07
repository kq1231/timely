import 'dart:async';
import 'dart:io';

import 'package:timely/common/list_struct/controllers/output_controller.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/common/scheduling/services/repo_service.dart';
import 'package:timely/reusables.dart';

// This is the tab 2 output controller.
// You will see this controller being used in tabs 2, 6 and 7.
// This is because all three tabs share the same methods of fetching and deleting
// the entries so it is useful to separate the common parts between them instead
// of creating three controllers that do exactly the same thing.
// Here, we only create the class. We create the providers inside the tab folders.

class SchedulingOutputNotifier<T> extends OutputNotifier<Tab2Model> {
  SchedulingOutputNotifier({required int tabNumber})
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
        .generateActivitiesForToday(tabNumber, modelizer);

    // Fetch the models from the db
    List<Tab2Model> models = await ref
        .read(schedulingRepositoryServiceProvider.notifier)
        .fetchModels(modelizer, currentFile);

    models.sort((a, b) {
      Duration dur = DateTime(0, 0, 0, a.startTime.hour, a.startTime.minute)
          .difference(DateTime(0, 0, 0, b.startTime.hour, b.startTime.minute));
      return dur.inMinutes;
    });

    return models;
  }
}
