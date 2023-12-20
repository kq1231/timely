import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/controllers/output_controller.dart';
import 'package:timely/modules/tab_10/repositories/pending_repo.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';

final tab10OutputProvider =
    AsyncNotifierProvider<OutputNotifier<Tab10Model>, List<Tab10Model>>(() {
  return OutputNotifier(
      tabNumber: 10,
      modelizer: Tab10Model.fromJson,
      pendingRepositoryProvider: pendingRepositoryProvider);
});
