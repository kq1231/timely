import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/repositories/pending_repo.dart';
import 'package:timely/modules/common/services/completion_service.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';
import 'package:timely/reusables.dart';

class Tab11OutputNotifier extends AsyncNotifier<List> {
  late File tab11PendingFile;
  late File tab11CompletedFile;

  @override
  FutureOr<List> build() async {
    tab11PendingFile =
        (await ref.read(dbFilesProvider.future)).tab11PendingFile;
    tab11CompletedFile =
        (await ref.read(dbFilesProvider.future)).tab11CompletedFile;

    return await ref
        .read(pendingRepositoryProvider.notifier)
        .fetchModels(Tab11Model.fromJson, tab11PendingFile);
  }

  Future<void> deleteModel(Tab11Model model) async {
    await ref
        .read(pendingRepositoryProvider.notifier)
        .deleteModel(model, tab11PendingFile);
  }

  Future<void> markModelAsComplete(Tab11Model model) async {
    await ref
        .read(completionServiceProvider.notifier)
        .markAsComplete(model, tab11PendingFile, tab11CompletedFile);
  }
}

final tab11OutputProvider =
    AsyncNotifierProvider<Tab11OutputNotifier, List>(Tab11OutputNotifier.new);
