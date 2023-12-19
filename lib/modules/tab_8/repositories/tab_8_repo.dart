import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';
import 'package:timely/reusables.dart';

class Tab8RepositoryNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<List<Tab8Model>> fetchAllTab8Models() async {
    final file = (await ref.read(dbFilesProvider.future))[8]![0];

    List jsonContent = jsonDecode(await file.readAsString());
    List<Tab8Model> models = [];
    for (Map obj in jsonContent) {
      models.add(Tab8Model.fromJson(obj));
    }

    return models;
  }

  Future<void> writeTab8Model(Tab8Model model) async {
    final file = (await ref.read(dbFilesProvider.future))[8]![0];

    List jsonContent = jsonDecode(await file.readAsString());
    jsonContent = [...jsonContent, model.toJson()];
    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> editModel(Tab8Model model) async {
    // Grab the file & content
    final file = (await ref.read(dbFilesProvider.future))[8]![0];
    List jsonContent = jsonDecode(await file.readAsString());

    // Loop through the models checking the ids
    // When match is found, edit the values
    for (int i in List.generate(jsonContent.length, (index) => index)) {
      if (jsonContent[i]["ID"] == model.uuid) {
        jsonContent[i] = model.toJson();
        break;
      }
    }

    // Sync with the database
    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> deleteModel(Tab8Model model) async {
    final File file = (await ref.read(dbFilesProvider.future))[8]![0];

    // Get the list of model maps
    List jsonContent = jsonDecode(await file.readAsString());

    // Remove the model whose id matches @model.uuid
    for (int i in List.generate(jsonContent.length, (index) => index)) {
      if (jsonContent[i]["ID"] == model.uuid) {
        jsonContent.removeAt(i);
        break;
      }
    }
    await file.writeAsString(jsonEncode(jsonContent));
  }
}

final tab8RepositoryProvider =
    AsyncNotifierProvider<Tab8RepositoryNotifier, void>(
        Tab8RepositoryNotifier.new);
