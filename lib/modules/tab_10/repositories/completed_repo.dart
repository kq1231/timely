import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/reusables.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab10CompletedRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeTab10ModelAsComplete(Tab10Model model) async {
    final tab10CompletedFile =
        (await ref.read(dbFilesProvider.future)).tab10CompletedFile;
    final jsonContent = jsonDecode(await tab10CompletedFile.readAsString());
    jsonContent.add(model.toJson());

    await tab10CompletedFile.writeAsString(jsonEncode(jsonContent));
  }
}

final tab10CompletedRepositoryProvider =
    NotifierProvider<Tab10CompletedRepositoryNotifier, AsyncValue<void>>(
        Tab10CompletedRepositoryNotifier.new);
