import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryStructCompletedRepositoryNotifier<T> extends Notifier<void> {
  @override
  build() {
    return;
  }

  // Methods:
  // completeEntry
  // completeSubEntry

  Future<void> writeEntryAsComplete(entry, List subEntries, File file) async {
    // Check if the entry is already present or not
    // If it is, just append the subEntries
    // Else, create a new one from scratch.

    final jsonContent = jsonDecode(await file.readAsString());
    bool isFound = false;

    for (int i in Iterable.generate(jsonContent.length)) {
      if (jsonContent[i]["uuid"] == entry.uuid) {
        jsonContent[i]["SubEntries"] = [
          ...jsonContent[i]["SubEntries"],
          ...subEntries.map(
            (e) => e.toJson(),
          )
        ];

        isFound = true;
        break;
      }
    }

    if (!isFound) {
      jsonContent.add({
        ...entry.toJson(),
        "SubEntries": subEntries
            .map(
              (e) => e.toJson().update("uuid", (value) => e.uuid),
            )
            .toList(),
      });
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> writeSubEntryAsComplete(entry, subEntry, File file) async {
    // Go through the entries
    // If $entry exists, then append the subEntry into it
    // Else, create a new entry and then append the subEntry

    List jsonContent = jsonDecode(await file.readAsString());
    bool isFound = false;
    for (int i in Iterable.generate(jsonContent.length)) {
      if (jsonContent[i]["uuid"] == entry.uuid) {
        jsonContent[i]["SubEntries"].add(subEntry.toJson());
      }
    }

    if (!isFound) {
      // Create the entry
      jsonContent.add({
        ...entry.toJson(),
        "SubEntries": [subEntry.toJson()],
      });
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }
}

final completedRepositoryProvider =
    NotifierProvider<EntryStructCompletedRepositoryNotifier, void>(
        EntryStructCompletedRepositoryNotifier.new);
