import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class PendingRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeModel(model, file) async {
    if (model.uuid != null) {
      await ref.read(pendingRepositoryProvider.notifier).editModel(model, file);
    } else {
      final jsonContent = jsonDecode(await file.readAsString());
      jsonContent.add(model.toJson());
      await file.writeAsString(jsonEncode(jsonContent));
    }
  }

  Future<List> fetchModels(toJsonMethod, file) async {
    final jsonContent = jsonDecode(await file.readAsString());
    final models = [];

    for (Map modelMap in jsonContent) {
      models.add(toJsonMethod(modelMap));
    }

    return models;
  }

  Future<void> deleteModel(model, file) async {
    // Fetch the data
    List jsonContent = jsonDecode(await file.readAsString());

    jsonContent.removeWhere((modelMap) {
      return modelMap["ID"] == model.uuid;
    });

    // Persist the data
    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> editModel(model, file) async {
    await deleteModel(model, file);
    await writeModel(model, file);
  }
}

final pendingRepositoryProvider =
    NotifierProvider<PendingRepositoryNotifier, AsyncValue<void>>(
        PendingRepositoryNotifier.new);
