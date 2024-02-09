import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/common/scheduling/services/repo_service.dart';
import 'package:timely/reusables.dart';

// This is the tab 2 output controller.
// You will see this controller being used in tabs 2, 6 and 7.
// This is because all three tabs share the same methods of fetching and deleting
// the entries so it is useful to separate the common parts between them instead
// of creating three controllers that do exactly the same thing.
// Here, we only create the class. We create the providers inside the tab folders.

class SchedulingOutputNotifier<T>
    extends AsyncNotifier<Map<String, List<Tab2Model>>> {
  late int tabNumber = 2;
  late File pendingFile;
  late File completedFile;
  late File currentFile;

  SchedulingOutputNotifier({
    required tabNumber,
  });

  @override
  FutureOr<Map<String, List<Tab2Model>>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[tabNumber]![1];
    currentFile = (await ref.read(dbFilesProvider.future))[tabNumber]!.last;

    var models = await ref
        .read(schedulingRepositoryServiceProvider.notifier)
        .fetchActivities(Tab2Model.fromJson, pendingFile);

    return models;
  }

  Future<void> deleteModel(Tab2Model model) async {
    ref
        .read(schedulingRepositoryServiceProvider.notifier)
        .deleteModel(model, pendingFile);
  }
}
