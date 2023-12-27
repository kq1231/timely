import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';

class CompletedRepositoryNotifier extends Notifier<void> {
  @override
  build() {
    return;
  }

  // Methods:
  // completeEntry
  // completeSubEntry

  Future<void> writeEntryAsComplete(
    Tab9EntryModel model,
    List<Tab9SubEntryModel> subEntries,
    File file,
  ) async {
    // Check if the entry is already present or not
    // If it is, just append the subEntries
    // Else, create a new one from scratch.

    final jsonContent = jsonDecode(await file.readAsString());
    bool isFound = false;

    for (int i in Iterable.generate(jsonContent.length)) {
      if (jsonContent[i]["uuid"] == model.uuid) {
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
        ...model.toJson(),
        "SubEntries": subEntries
            .map(
              (e) => e.toJson().update("uuid", (value) => e.uuid),
            )
            .toList(),
      });
    }

    await file.writeAsString(jsonEncode(jsonContent));
  }
}

final completedRepositoryProvider =
    NotifierProvider<CompletedRepositoryNotifier, void>(
        CompletedRepositoryNotifier.new);
