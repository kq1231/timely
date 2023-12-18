import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/repositories/pending_repo.dart';
import 'package:timely/modules/common/services/completion_service.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';

class OutputNotifier extends AsyncNotifier<List> {
  late File pendingFile;
  late File completedFile;
  late Function modelizeMethod;

  OutputNotifier(
      {required pendingFile, required completedFile, required modelizeMethod});

  @override
  FutureOr<List> build() async {
    return await ref
        .read(pendingRepositoryProvider.notifier)
        .fetchModels(modelizeMethod, pendingFile);
  }

  Future<void> deleteModel(Tab11Model model) async {
    await ref
        .read(pendingRepositoryProvider.notifier)
        .deleteModel(model, pendingFile);
  }

  Future<void> markModelAsComplete(Tab11Model model) async {
    await ref
        .read(completionServiceProvider.notifier)
        .markAsComplete(model, pendingFile, completedFile);
  }
}
