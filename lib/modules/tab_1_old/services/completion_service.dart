import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1_old/repositories/completed_repo.dart';
import 'package:timely/modules/tab_1_old/repositories/pending_repo.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab1CompletionServiceNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> markModelAsComplete(model) async {
    // Shift the model from pending DB to completed DB and refresh immediately
    // after model is removed from pending DB.
    await ref.read(tab1PendingRepositoryProvider.notifier).deleteModel(model);
    await ref
        .read(tab1CompletedRepositoryProvider.notifier)
        .writeModelAsComplete(model);
  }
}

final tab1CompletionServiceProvider =
    NotifierProvider<Tab1CompletionServiceNotifier, AsyncValue<void>>(
        Tab1CompletionServiceNotifier.new);
