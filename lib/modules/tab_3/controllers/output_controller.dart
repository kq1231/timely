import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/services/repo_service.dart';
import 'package:timely/reusables.dart';

class OutputNotifier extends AsyncNotifier<Map<String, List<Tab3Model>>> {
  final int tabNumber = 3;
  late File pendingFile;
  late File completedFile;
  final repositoryServiceProvider = tab3RepositoryServiceProvider;

  @override
  FutureOr<Map<String, List<Tab3Model>>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[tabNumber]![1];

    return await ref
        .read(repositoryServiceProvider.notifier)
        .fetchModels(pendingFile);
  }

  Future<void> deleteModel(Tab3Model model) async {
    await ref
        .read(repositoryServiceProvider.notifier)
        .deleteModel(model, pendingFile);
  }

  Future<void> markModelAsComplete(Tab3Model model) async {
    await ref
        .read(repositoryServiceProvider.notifier)
        .markAsComplete(model, pendingFile, completedFile);
  }
}

final tab3OutputProvider =
    AsyncNotifierProvider<OutputNotifier, Map<String, List<Tab3Model>>>(
        OutputNotifier.new);
