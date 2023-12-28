import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/reusables.dart';
import 'package:uuid/uuid.dart';

class Tab4RepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  // Methods
  Future<void> writeModel(Tab3Model model) async {
    final file = (await ref.read(dbFilesProvider.future))[4]![0];
    List content = jsonDecode(await file.readAsString());

    content = [
      ...content,
      {
        "ID": const Uuid().v4(),
        "Activity": model.text_1,
        "Priority": model.priority,
      },
    ];

    await file.writeAsString(jsonEncode(content));
  }

  Future<List<Tab3Model>> fetchTab4Models() async {
    final file = (await ref.read(dbFilesProvider.future))[4]![0];
    List jsonContent = jsonDecode(await file.readAsString());
    List<Tab3Model> models = <Tab3Model>[];

    for (Map indCon in jsonContent) {
      models.add(Tab3Model.fromJson(null, indCon));
    }
    return models;
  }

  Future<void> deleteModel(Tab3Model model) async {
    final file = (await ref.read(dbFilesProvider.future))[4]![0];
    List jsonContent = jsonDecode(await file.readAsString());

    jsonContent.removeWhere((modelMap) => modelMap["ID"] == model.uuid);

    // Persist the data
    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> editModel(Tab3Model model) async {
    await deleteModel(model);
    await writeModel(model);
  }

  Future<void> markModelAsComplete(Tab3Model model) async {
    await deleteModel(model);
    final file = (await ref.read(dbFilesProvider.future))[4]![1];
    List content = jsonDecode(await file.readAsString());
    content.add(model.toJson());
    await file.writeAsString(jsonEncode(content));
  }
}

final tab4RepositoryProvider =
    NotifierProvider<Tab4RepositoryNotifier, AsyncValue<void>>(
        Tab4RepositoryNotifier.new);
