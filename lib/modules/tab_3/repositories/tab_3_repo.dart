import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/reusables.dart';
import "dart:collection";

// This is the repository for tab 3.
// Repositories have one job: communicate with the external, third world.
// In our case, this repository is supposed to perform CRUD operations
// on tab 3 database.
// The methods of the repository are then used by the controllers.
// Using repositories eliminates code duplication as we do not have to copy-and-paste
// the same CRUD logic across all our providers.

class Tab3RepositoryNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<Map<String, dynamic>> fetchModels() async {
    final scheduled = (ref.read(dbFilesProvider)).requireValue[3]![0];
    final nonScheduled = (ref.read(dbFilesProvider)).requireValue[3]![1];

    final scheduledContent = jsonDecode(await scheduled.readAsString());
    final nonScheduledContent = jsonDecode(await nonScheduled.readAsString());

    final dates = scheduledContent.keys.toList();

    Map<String, dynamic> tab3Models = {
      "scheduled": {},
      "nonScheduled": [],
    };
    for (String date in dates) {
      tab3Models["scheduled"]![date] = [];
      for (Map content in scheduledContent[date]) {
        tab3Models["scheduled"]![date]!.add(
          Tab3Model.fromJson(
            DateTime.parse(date),
            content,
          ),
        );
      }
    }

    for (Map modelMap in nonScheduledContent) {
      tab3Models["nonScheduled"]!.add(Tab3Model.fromJson(null, modelMap));
    }

    return tab3Models;
  }

  Future<void> writeModel(Tab3Model model) async {
    final scheduled = (ref.read(dbFilesProvider)).requireValue[3]![0];
    final nonScheduled = (ref.read(dbFilesProvider)).requireValue[3]![1];

    final scheduledContent = jsonDecode(await scheduled.readAsString());
    final nonScheduledContent = jsonDecode(await nonScheduled.readAsString());

    if (model.date != null && model.time != null) {
      String date = model.date.toString().substring(0, 10);

      if (!scheduledContent.keys.contains(date)) {
        scheduledContent[date] = [];
      }

      scheduledContent[date] = [
        ...scheduledContent[date], // -> Existing data
        // New data:
        model.toJson(),
      ];
    } else {
      nonScheduledContent.add(
        model.toJson(),
      );
      nonScheduled.writeAsString(jsonEncode(nonScheduledContent));
    }

    await scheduled.writeAsString(jsonEncode(scheduledContent));
  }

  Future<void> deleteModel(Tab3Model model) async {
    // Fetch the data
    final scheduled = (ref.read(dbFilesProvider)).requireValue[3]![0];
    final nonScheduled = (ref.read(dbFilesProvider)).requireValue[3]![1];

    final scheduledContent = jsonDecode(await scheduled.readAsString());
    final nonScheduledContent = jsonDecode(await nonScheduled.readAsString());

    // Loop through the dates
    // Delete the model from the data if model.uuid == $model.uuid
    for (String date in scheduledContent.keys) {
      scheduledContent[date].removeWhere((modelMap) {
        return modelMap["ID"] == model.uuid;
      });
    }

    // Remove the date entirely if it is empty
    scheduledContent.removeWhere((key, value) => value.length == 0);

    // Persist the data
    await scheduled.writeAsString(jsonEncode(scheduledContent));

    nonScheduledContent.removeWhere((element) => element.uuid == model.uuid);
    await nonScheduled.writeAsString(jsonEncode(nonScheduledContent));
  }

  Future<void> editModel(Tab3Model model) async {
    await deleteModel(model);
    await writeModel(model);
  }
}
