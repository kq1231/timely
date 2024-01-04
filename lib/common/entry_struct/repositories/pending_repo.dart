import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryStructPendingRepositoryNotifier<T, V> extends Notifier<void> {
  @override
  void build() {}

  // Methods:

  // Create: entry, subEntry
  Future<void> writeEntry(model, File file, List? subEntries) async {
    final jsonContent = jsonDecode(await file.readAsString());

    jsonContent.add({
      ...model.toJson(),
      "SubEntries": subEntries ?? [],
    });
    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> writeSubEntry(
    String entryUuid,
    subEntry,
    File file,
    entryModel,
    entryModelizer,
    subEntryModelizer,
  ) async {
    List jsonContent = jsonDecode(await file.readAsString());
    bool isFound = false;
    for (int i in Iterable.generate(jsonContent.length)) {
      if (entryModelizer(jsonContent[i])!.uuid == entryUuid) {
        jsonContent[i]["SubEntries"].add(subEntry.toJson());
        isFound = true;
        break;
      }
    }

    await file.writeAsString(jsonEncode(jsonContent));

    if (!isFound) {
      await writeEntry(entryModel!, file, null);
      await writeSubEntry(
        entryUuid,
        subEntry,
        file,
        null,
        entryModelizer,
        subEntryModelizer,
      );
    }
  }

  // Read: entries and subEntries
  Future<Map<T, List<V>>> fetchEntriesAndSubEntries(
    File file,
    entryModelizer,
    subEntryModelizer,
  ) async {
    Map<T, List<V>> entriesAndSubEntries = {};
    final List jsonContent = jsonDecode(await file.readAsString());

    for (int i in Iterable.generate(jsonContent.length)) {
      T entryModel = entryModelizer(jsonContent[i]);
      entriesAndSubEntries[entryModel] = [];

      for (var json in jsonContent[i]["SubEntries"]) {
        entriesAndSubEntries[entryModel]!.add(subEntryModelizer(json));
      }
    }
    return entriesAndSubEntries;
  }

  // Update: entry, subEntry
  Future<void> updateEntry(
    model,
    File file,
    entryModelizer,
  ) async {
    List jsonContent = jsonDecode(await file.readAsString());
    for (int i in Iterable.generate(jsonContent.length)) {
      if (entryModelizer(jsonContent[i]).uuid == model.uuid) {
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
      String entryUuid, subEntry, File file, entryModelizer) async {
    List jsonContent = jsonDecode(await file.readAsString());
    for (int i in Iterable.generate(jsonContent.length)) {
      if (entryModelizer(jsonContent[i]).uuid == entryUuid) {
        List subEntries = jsonContent[i]["SubEntries"];
        for (int j in Iterable.generate(subEntries.length)) {
          if (subEntries[j]["ID"] == subEntry.uuid) {
            subEntries[j] = subEntry.toJson();
            jsonContent[i]["SubEntries"] = subEntries;
            break;
          }
        }
        break;
      }
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }

  // Delete: entry, subEntry
  Future<void> deleteEntry(entry, File file) async {
    List jsonContent = jsonDecode(await file.readAsString());

    jsonContent.removeWhere((element) => element["ID"] == entry.uuid);

    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> deleteSubEntry(
    String entryUuid,
    subEntry,
    File file,
  ) async {
    List jsonContent = jsonDecode(await file.readAsString());

    for (int i in Iterable.generate(jsonContent.length)) {
      if (jsonContent[i]["ID"] == entryUuid) {
        jsonContent[i]["SubEntries"]
            .removeWhere((element) => element["ID"] == subEntry.uuid);
      }
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }
}
