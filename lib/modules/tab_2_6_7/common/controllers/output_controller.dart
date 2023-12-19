import 'dart:async';

import 'package:timely/modules/common/controllers/output_controller.dart';
import 'package:timely/modules/tab_2_6_7/common/models/tab_2_model.dart';
import 'package:timely/modules/tab_2_6_7/common/repositories/repo.dart';
import 'package:timely/reusables.dart';

class Tab2OutputNotifier extends OutputNotifier {
  Tab2OutputNotifier({required super.tabNumber, required super.modelizeMethod});

  @override
  FutureOr<List> build() async {
    final file = (await ref.read(dbFilesProvider.future))[tabNumber]![0];

    await ref
        .read(tab2RepositoryProvider.notifier)
        .generateActivitiesForToday(file);

    // Fetch the models from the db
    List<Tab2Model> models = await ref
        .read(tab2RepositoryProvider.notifier)
        .fetchTab2ModelsForToday(file);

    return models;
  }
}
