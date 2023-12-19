import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/repositories/pending_repo.dart';
import 'package:timely/modules/common/services/completion_service.dart';
import 'package:timely/reusables.dart';

class OutputNotifier extends AsyncNotifier<List> {
  late int tabNumber;
  late File pendingFile;
  late File completedFile;
  late Function modelizer;

  OutputNotifier({required this.tabNumber, required this.modelizer});

  @override
  FutureOr<List> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];

    return await ref
        .read(pendingRepositoryProvider.notifier)
        .fetchModels(modelizer, pendingFile);
  }

  Future<void> deleteModel(model) async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    await ref
        .read(pendingRepositoryProvider.notifier)
        .deleteModel(model, pendingFile);
  }

  Future<void> markModelAsComplete(model) async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[tabNumber]![1];

    await ref
        .read(completionServiceProvider.notifier)
        .markModelAsComplete(model, pendingFile, completedFile);
  }
}
