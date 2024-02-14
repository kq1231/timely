import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/common/scheduling/services/repo_service.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:timely/modules/home/providers/external_entries_provider.dart';
=======
>>>>>>> 1237990 (Added end time)
=======
import 'package:timely/modules/home/providers/todays_model_maps_provider.dart';
>>>>>>> e04da1c (Repository Completed)
import 'package:timely/reusables.dart';

// This is the tab 2 output controller.
// You will see this controller being used in tabs 2, 6 and 7.
// This is because all three tabs share the same methods of fetching and deleting
// the entries so it is useful to separate the common parts between them instead
// of creating three controllers that do exactly the same thing.
// Here, we only create the class. We create the providers inside the tab folders.

class SchedulingOutputNotifier<T>
    extends AutoDisposeAsyncNotifier<Map<String, List<Tab2Model>>> {
  SchedulingOutputNotifier(this.tabNumber);

  final int tabNumber;
  late File pendingFile;
  late File completedFile;
  late File currentFile;

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
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[tabNumber]![1];
    currentFile = (await ref.read(dbFilesProvider.future))[tabNumber]!.last;

    await ref
        .read(schedulingRepositoryServiceProvider.notifier)
        .deleteModel(model, pendingFile);
<<<<<<< HEAD

<<<<<<< HEAD
    ref.invalidate(externalEntriesProvider);
=======
>>>>>>> 1237990 (Added end time)
=======
    ref.invalidate(todaysModelMapsProvider);
>>>>>>> e04da1c (Repository Completed)
  }
}
