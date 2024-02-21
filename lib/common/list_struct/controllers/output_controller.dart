import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/list_struct/repositories/repo.dart';
import 'package:timely/modules/home/providers/todays_model_maps_provider.dart';
import 'package:timely/reusables.dart';

class OutputNotifier<T> extends AutoDisposeAsyncNotifier<List<T>> {
  late int tabNumber;
  late File pendingFile;
  late File completedFile;
  late Function modelizer;
  late final NotifierProvider<ListStructRepositoryNotifier<T>, void>
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
    ref.invalidate(todaysModelMapsProvider);
  }
}
