import 'dart:async';

import 'package:timely/common/notifiers/controllers/output_controller.dart';
import 'package:timely/modules/tab_2_6_7/common/models/tab_2_model.dart';
import 'package:timely/modules/tab_2_6_7/common/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab2OutputNotifier<T> extends OutputNotifier<Tab2Model> {
  Tab2OutputNotifier({required int tabNumber})
      : super(
            tabNumber: tabNumber,
            modelizer: Tab2Model.fromJson,
            repositoryServiceProvider: repositoryServiceProvider);

  @override
  FutureOr<List<Tab2Model>> build() async {
    final file = (await ref.read(dbFilesProvider.future))[tabNumber]![0];

    await ref
        .read(repositoryServiceProvider.notifier)
        .generateActivitiesForToday(modelizer, file);

    // Fetch the models from the db
    List<Tab2Model> models = await ref
        .read(repositoryServiceProvider.notifier)
        .fetchModels(modelizer, file);

    return models;
  }
}
