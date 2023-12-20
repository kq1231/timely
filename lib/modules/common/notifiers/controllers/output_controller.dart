import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/repositories/completed_repo.dart';
import 'package:timely/modules/common/notifiers/repositories/pending_repo.dart';
import 'package:timely/reusables.dart';

class OutputNotifier<T> extends AsyncNotifier<List<T>> {
  late int tabNumber;
  late File pendingFile;
  late File completedFile;
  late Function modelizer;
  late final NotifierProvider<PendingRepositoryNotifier<T>, AsyncValue<void>>
      pendingRepositoryProvider;
  late final NotifierProvider<CompletedRepositoryNotifier, AsyncValue<void>>
      completedRepositoryProvider;

  OutputNotifier({
    required this.tabNumber,
    required this.modelizer,
    required this.pendingRepositoryProvider,
  });

  @override
  FutureOr<List<T>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[tabNumber]![1];

    return await ref
        .read(pendingRepositoryProvider.notifier)
        .fetchModels(modelizer, pendingFile);
  }

  Future<void> deleteModel(T model) async {
    await ref
        .read(pendingRepositoryProvider.notifier)
        .deleteModel(model, pendingFile);
  }

  Future<void> markModelAsComplete(T model) async {
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
