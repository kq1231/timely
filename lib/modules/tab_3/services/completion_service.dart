import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/repositories/completed_repo.dart';
import 'package:timely/modules/tab_3/repositories/pending_repo.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab3CompletionServiceNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> markModelAsComplete(model) async {
    // Shift the model from pending DB to completed DB and refresh immediately
    // after model is removed from pending DB.
    await ref.read(tab3PendingRepositoryProvider.notifier).deleteModel(model);
    await ref
        .read(tab3CompletedRepositoryProvider.notifier)
        .writeModelAsComplete(model);
  }
}

final tab3CompletionServiceProvider =
    NotifierProvider<Tab3CompletionServiceNotifier, AsyncValue<void>>(
        Tab3CompletionServiceNotifier.new);
