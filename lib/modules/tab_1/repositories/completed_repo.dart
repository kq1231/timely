import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/reusables.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab1CompletedRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeModelAsComplete(model) async {
    final file = (await ref.read(dbFilesProvider.future))[1]![1];
    Map jsonContent = jsonDecode(await file.readAsString());
    jsonContent[model.date] = [];
    jsonContent[model.date].add(
      [
        model.fScore,
        model.mScore,
        model.sScore,
      ],
    );
    jsonContent[model.date].add(
      "${model.nextUpdateTime.hour}: ${model.nextUpdateTime.minute}",
    );
    jsonContent[model.date].add(model.text_1);

    await file.writeAsString(jsonEncode(jsonContent));
  }
}

final tab1CompletedRepositoryProvider =
    NotifierProvider<Tab1CompletedRepositoryNotifier, AsyncValue<void>>(
        Tab1CompletedRepositoryNotifier.new);
