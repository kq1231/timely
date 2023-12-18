import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/repositories/completed_repo.dart';
import 'package:timely/modules/common/repositories/pending_repo.dart';

/// '''This service<[Notifier]> communicates between two repositories.'''

class CompletionServiceNotifier extends AutoDisposeNotifier<void> {
  @override
  void build() {}

  // Methods
  Future<void> markAsComplete(model, pendingFile, completedFile) async {
    // Shift the model from pending DB to completed DB and refresh immediately
    // after model is removed from pending DB.
    await ref
        .read(pendingRepositoryProvider.notifier)
        .deleteModel(model, pendingFile);
    await ref
        .read(completedRepositoryProvider.notifier)
        .writeModelAsComplete(model, completedFile);
  }
}

final completionServiceProvider =
    AutoDisposeNotifierProvider<CompletionServiceNotifier, void>(
        CompletionServiceNotifier.new);
