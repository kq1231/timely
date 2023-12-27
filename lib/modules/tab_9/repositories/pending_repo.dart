import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:uuid/uuid.dart';

class PendingRepositoryNotifier extends Notifier<void> {
  @override
  void build() {}

  // Methods:

  // Create: entry, subEntry
  Future<void> writeEntry(
      Tab9EntryModel model, File file, List? subEntries) async {
    final jsonContent = jsonDecode(await file.readAsString());

    model = model.copyWith(uuid: model.uuid ?? const Uuid().v4());

    jsonContent.add({
      ...model.toJson(),
      "SubEntries": subEntries ?? [],
    });
    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> writeSubEntry(
    String entryUuid,
    Tab9SubEntryModel model,
    File file,
    Tab9EntryModel? entryModel,
  ) async {
    List jsonContent = jsonDecode(await file.readAsString());
    bool isFound = false;
    for (int i in Iterable.generate(jsonContent.length)) {
      if (Tab9EntryModel.fromJson(jsonContent[i]).uuid == entryUuid) {
        jsonContent[i]["SubEntries"].add(model.toJson());
        isFound = true;
        break;
      }
    }

    await file.writeAsString(jsonEncode(jsonContent));

    if (!isFound) {
      await writeEntry(entryModel!, file, null);
      await writeSubEntry(entryUuid, model, file, null);
    }
  }

  // Read: entries and subEntries
  Future<Map<Tab9EntryModel, List<Tab9SubEntryModel>>>
      fetchEntriesAndSubEntries(File file) async {
    Map<Tab9EntryModel, List<Tab9SubEntryModel>> entriesAndSubEntries = {};
    final List jsonContent = jsonDecode(await file.readAsString());

    for (int i in Iterable.generate(jsonContent.length)) {
      Tab9EntryModel entryModel = Tab9EntryModel.fromJson(jsonContent[i]);
      entriesAndSubEntries[entryModel] = [];

      for (var json in jsonContent[i]["SubEntries"]) {
        entriesAndSubEntries[entryModel]!.add(Tab9SubEntryModel.fromJson(json));
      }
    }
    return entriesAndSubEntries;
  }

  // Update: entry, subEntry
  Future<void> updateEntry(Tab9EntryModel model, File file) async {
    List jsonContent = jsonDecode(await file.readAsString());
    for (int i in Iterable.generate(jsonContent.length)) {
      if (Tab9EntryModel.fromJson(jsonContent[i]).uuid == model.uuid) {
        jsonContent[i] = {
          ...model.toJson(),
          "SubEntries": jsonContent[i]["SubEntries"]
        };
        break;
      }
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> updateSubEntry(
      String entryUuid, Tab9SubEntryModel model, File file) async {
    List jsonContent = jsonDecode(await file.readAsString());
    for (int i in Iterable.generate(jsonContent.length)) {
      if (Tab9EntryModel.fromJson(jsonContent[i]).uuid == entryUuid) {
        List subEntries = jsonContent[i]["SubEntries"];
        for (int j in Iterable.generate(subEntries.length)) {
          if (subEntries[j]["uuid"] == model.uuid) {
            subEntries[j] = model.toJson();
            jsonContent[i]["SubEntries"] = subEntries;
            break;
          }
        }
      }
      break;
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }

  // Delete: entry, subEntry
  Future<void> deleteEntry(Tab9EntryModel model, File file) async {
    List jsonContent = jsonDecode(await file.readAsString());

    jsonContent.removeWhere((element) => element["uuid"] == model.uuid);

    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> deleteSubEntry(
      String entryUuid, Tab9SubEntryModel model, File file) async {
    List jsonContent = jsonDecode(await file.readAsString());

    for (int i in Iterable.generate(jsonContent.length)) {
      if (Tab9EntryModel.fromJson(jsonContent[i]).uuid == entryUuid) {
        jsonContent[i]["SubEntries"]
            .removeWhere((element) => element["uuid"] == model.uuid);
      }
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }
}
