import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/list_struct/controllers/output_controller.dart';
import 'package:timely/modules/tab_10/services/repo_service.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';

final tab10OutputProvider =
    AsyncNotifierProvider<OutputNotifier<Tab10Model>, List<Tab10Model>>(() {
  return OutputNotifier(
    tabNumber: 10,
    modelizer: Tab10Model.fromJson,
    repositoryServiceProvider: tab10RepositoryServiceProvider,
  );
});
