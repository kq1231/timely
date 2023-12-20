import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/controllers/output_controller.dart';
import 'package:timely/modules/tab_11/repositories/pending_repo.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';

final tab11OutputProvider =
    AsyncNotifierProvider<OutputNotifier<Tab11Model>, List<Tab11Model>>(() {
  return OutputNotifier(
      tabNumber: 11,
      modelizer: Tab11Model.fromJson,
      pendingRepositoryProvider: pendingRepositoryProvider);
});
