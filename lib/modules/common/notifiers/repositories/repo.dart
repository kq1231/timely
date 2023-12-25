import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepositoryNotifier<T> extends Notifier<void> {
  @override
  build() {
    return;
  }

  Future<void> writeModel(model, file) async {
    final jsonContent = jsonDecode(await file.readAsString());
    jsonContent.add(model.toJson());
    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<List<T>> fetchModels(Function modelizer, file) async {
    final jsonContent = jsonDecode(await file.readAsString());
    final models = <T>[];

    for (Map modelMap in jsonContent) {
      models.add(modelizer(modelMap));
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
