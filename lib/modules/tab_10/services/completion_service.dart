import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/modules/tab_10/repositories/completed_repo.dart';
import 'package:timely/modules/tab_10/repositories/pending_repo.dart';

class Tab10CompletionServiceNotifier extends AutoDisposeNotifier<void> {
  @override
  void build() {}

  // Methods
  Future<void> markAsComplete(Tab10Model model) async {
    // Shift the model from pending DB to completed DB and refresh immediately
    // after model is removed from pending DB.
    await ref.read(tab10PendingRepositoryProvider.notifier).deleteModel(model);
    await ref
        .read(tab10CompletedRepositoryProvider.notifier)
        .writeTab10ModelAsComplete(model);
  }
}

final tab10CompletionServiceProvider =
    AutoDisposeNotifierProvider<Tab10CompletionServiceNotifier, void>(
        Tab10CompletionServiceNotifier.new);
