import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/notifiers/services/repo_service.dart';
import 'package:timely/reusables.dart';

class OutputNotifier<T> extends AsyncNotifier<List<T>> {
  late int tabNumber;
  late File pendingFile;
  late File completedFile;
  late Function modelizer;
  late final NotifierProvider<RepositoryService<T>, void>
      repositoryServiceProvider;

  OutputNotifier({
    required this.tabNumber,
    required this.modelizer,
    required this.repositoryServiceProvider,
  });

  @override
  FutureOr<List<T>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[tabNumber]![1];

    return await ref
        .read(repositoryServiceProvider.notifier)
        .fetchModels(modelizer, pendingFile);
  }

  Future<void> deleteModel(T model) async {
    await ref
        .read(repositoryServiceProvider.notifier)
        .deleteModel(model, pendingFile);
  }

  Future<void> markModelAsComplete(T model) async {
    await ref
        .read(repositoryServiceProvider.notifier)
        .markModelAsComplete(model, pendingFile, completedFile);
  }
}
