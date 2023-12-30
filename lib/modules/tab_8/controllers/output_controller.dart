import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/list_struct/controllers/output_controller.dart';
import 'package:timely/modules/tab_8/services/repo_service.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';

final tab8OutputProvider =
    AsyncNotifierProvider<OutputNotifier<Tab8Model>, List<Tab8Model>>(() {
  return OutputNotifier(
    tabNumber: 8,
    modelizer: Tab8Model.fromJson,
    repositoryServiceProvider: tab8RepositoryServiceProvider,
  );
});
