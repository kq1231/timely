import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1_old/models/fms_model.dart';
import 'package:timely/modules/tab_1_old/repositories/pending_repo.dart';
import 'package:timely/modules/tab_1_old/services/completion_service.dart';

class Tab1OutputNotifier extends AsyncNotifier<List<FMSModel>> {
  @override
  FutureOr<List<FMSModel>> build() async {
    var res =
        await ref.read(tab1PendingRepositoryProvider.notifier).fetchFMSModels();
    return res;
  }

  Future<void> deleteModel(model) async {
    await ref.read(tab1PendingRepositoryProvider.notifier).deleteModel(model);
  }

  Future<void> markModelAsComplete(model) async {
    await ref
        .read(tab1CompletionServiceProvider.notifier)
        .markModelAsComplete(model);
  }
}

final tab1OutputProvider =
    AsyncNotifierProvider<Tab1OutputNotifier, List<FMSModel>>(() {
  return Tab1OutputNotifier();
});
