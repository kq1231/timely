import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class CompletedRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeModelAsComplete(model, file) async {
    final jsonContent = jsonDecode(await file.readAsString());
    jsonContent.add(model.toJson());

    await file.writeAsString(jsonEncode(jsonContent));
  }
}

final completedRepositoryProvider =
    NotifierProvider<CompletedRepositoryNotifier, AsyncValue<void>>(
        CompletedRepositoryNotifier.new);
