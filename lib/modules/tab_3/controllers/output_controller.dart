import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/services/repo_service.dart';
import 'package:timely/reusables.dart';

class OutputNotifier extends AsyncNotifier<Map<String, dynamic>> {
  final int tabNumber = 3;
  late File scheduled;
  late File nonScheduled;
  final repositoryServiceProvider = tab3RepositoryServiceProvider;

  @override
  FutureOr<Map<String, dynamic>> build() async {
    scheduled = (await ref.read(dbFilesProvider.future))[3]![0];
    nonScheduled = (await ref.read(dbFilesProvider.future))[3]![1];

    return await ref.read(repositoryServiceProvider.notifier).fetchModels();
  }

  Future<void> deleteModel(Tab3Model model) async {
    await ref.read(repositoryServiceProvider.notifier).deleteModel(model);
  }

  Future<void> markModelAsComplete(Tab3Model model) async {
    await ref
        .read(repositoryServiceProvider.notifier)
        .markAsComplete(model, scheduled, nonScheduled);
  }
}

final tab3OutputProvider =
    AsyncNotifierProvider<OutputNotifier, Map<String, dynamic>>(
        OutputNotifier.new);
