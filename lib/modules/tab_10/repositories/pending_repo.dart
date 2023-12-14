import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/reusables.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab10PendingRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeTab10Model(Tab10Model model) async {
    final tab10PendingFile =
        (await ref.read(dbFilesProvider.future)).tab10PendingFile;
    final jsonContent = jsonDecode(await tab10PendingFile.readAsString());
    jsonContent.add(model.toJson());

    await tab10PendingFile.writeAsString(jsonEncode(jsonContent));
  }

  Future<List<Tab10Model>> fetchTab10Models() async {
    final tab10PendingFile =
        (await ref.read(dbFilesProvider.future)).tab10PendingFile;
    final jsonContent = jsonDecode(await tab10PendingFile.readAsString());
    final tab10Models = <Tab10Model>[];

    for (Map modelMap in jsonContent) {
      tab10Models.add(Tab10Model.fromJson(modelMap));
    }

    return tab10Models;
  }

  Future<void> deleteModel(Tab10Model model) async {
    // Fetch the data
    final tab10PendingFile =
        (await ref.read(dbFilesProvider.future)).tab10PendingFile;
    List jsonContent = jsonDecode(await tab10PendingFile.readAsString());

    jsonContent.removeWhere((modelMap) {
      return modelMap["ID"] == model.uuid;
    });

    // Persist the data
    await tab10PendingFile.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> editModel(Tab10Model model) async {
    await deleteModel(model);
    await writeTab10Model(model);
  }
}

final tab10PendingRepositoryProvider =
    NotifierProvider<Tab10PendingRepositoryNotifier, AsyncValue<void>>(
        Tab10PendingRepositoryNotifier.new);
