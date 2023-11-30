import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/reusables.dart';

class Tab2RepostioryNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<List<Tab2Model>> fetchAllTab2Models() async {
    final tab2File = (await ref.read(dbFilesProvider.future)).tab2File;
    List jsonContent = jsonDecode(await tab2File.readAsString());
    List<Tab2Model> models = [];
    for (Map obj in jsonContent) {
      models.add(Tab2Model.fromJson(obj));
    }

    return models;
  }

  Future<List<Tab2Model>> fetchTab2ModelsForToday() async {
    // Grab the file
    final tab2CurrentActivitiesFile =
        (await ref.read(dbFilesProvider.future)).tab2CurrentActivitiesFile;

    // Extract the contents
    var content = jsonDecode(await tab2CurrentActivitiesFile.readAsString());

    // Loop over and extract the models
    List<Tab2Model> models = [];
    for (var modelMap in content) {
      models.add(Tab2Model.fromJson(modelMap));
    }

    return models;
  }

  Future<void> writeTab2Model(Tab2Model model) async {
    final tab2File = (await ref.read(dbFilesProvider.future)).tab2File;
    List jsonContent = jsonDecode(await tab2File.readAsString());

    jsonContent = [...jsonContent, model.toJson()];

    await tab2File.writeAsString(jsonEncode(jsonContent));
  }

  Future<List> getActivitiesForToday() async {
    // Functions for DRYness
    List<int> getOccurences(
        Tab2Model model, int ordinalPosition, int dayOfWeek) {
      List<int> occurences = [];

      // Get all occurences of $day
      int firstOccurence = 0;
      int num = 0;
      while (true) {
        num++;
        if (DateTime(DateTime.now().year, DateTime.now().month, num).weekday ==
            (dayOfWeek + 1)) {
          firstOccurence = num - 1; // As index.
          break;
        }
      }
      num = 0;
      while (true) {
        num++;
        if ((firstOccurence + 1) + (7 * num) < 31) {
          occurences.add((firstOccurence + 1) + (7 * num));
        } else {
          break;
        }
      }
      return [firstOccurence, ...occurences];
    }

    List<Map> checkWithOrdinalPosition(List<int> occurences,
        int ordinalPosition, Tab2Model model, List<Map> currentModels) {
      try {
        if (ordinalPosition != 5) {
          if (DateTime.now().day == occurences[ordinalPosition]) {
            currentModels.add(model.toJson());
          }
        } else {
          if (DateTime.now().day == occurences.last) {
            currentModels.add(model.toJson());
          }
        }
      } catch (e) {
        // Skip it.
      }
      return currentModels;
    }

    // Get the models
    List models = await fetchAllTab2Models();

    // Create an array of selected models
    List<Map> currentModels = [];

    // Compare the dates in different cases
    for (Tab2Model model in models) {
      switch (model.frequency) {
        case "Daily":
          currentModels.add(model.toJson());
          break;

        case "Weekly":
          List weekdays = model.repetitions["Weekdays"];
          if (weekdays.contains(DateTime.now().weekday - 1)) {
            currentModels.add(model.toJson());
          }
          break;

        case "Monthly":
          if (model.basis == Basis.day) {
            int ordinalPosition = model.repetitions["DoW"][0];
            int dayOfWeek = model.repetitions["DoW"][1];
            List<int> occurences =
                getOccurences(model, ordinalPosition, dayOfWeek);

            // Check with ordinal position and today's date
            currentModels = checkWithOrdinalPosition(
                occurences, ordinalPosition, model, currentModels);

            // Check for Basis.date
          } else if (model.basis == Basis.date) {
            if (model.repetitions["Dates"].contains(DateTime.now().day)) {
              currentModels.add(model.toJson());
            }
          }

        case "Yearly":
          if (model.basis == Basis.day) {
            // Check if the current month exists inside $Months
            if (model.repetitions["Months"].contains(DateTime.now().month)) {
              int ordinalPosition = model.repetitions["DoW"][0];
              int dayOfWeek = model.repetitions["DoW"][1];

              List<int> occurences =
                  getOccurences(model, ordinalPosition, dayOfWeek);

              // Check with ordinal position and today's date
              currentModels = checkWithOrdinalPosition(
                  occurences, ordinalPosition, model, currentModels);
            }
          }
        default:
          break;
      }
    }
    return currentModels;
  }

  Future<void> generateActivitiesForToday() async {
    // Grab the file
    final tab2CurrentActivitiesFile =
        (await ref.read(dbFilesProvider.future)).tab2CurrentActivitiesFile;

    // Save to the file
    await tab2CurrentActivitiesFile
        .writeAsString(jsonEncode(await getActivitiesForToday()));
  }

  Future<void> writeEditedModel(Tab2Model model) async {
    // Grab the file & content
    final tab2File = (await ref.read(dbFilesProvider.future)).tab2File;
    List jsonContent = jsonDecode(await tab2File.readAsString());

    // Loop through the models checking the ids
    // When match is found, edit the values

    for (int i in List.generate(jsonContent.length, (index) => index)) {
      if (jsonContent[i]["ID"] == model.uuid) {
        jsonContent[i] = model.toJson();
        break;
      }
    }

    // Sync with the database
    await tab2File.writeAsString(jsonEncode(jsonContent));
  }
}

final tab2RepositoryProvider =
    AsyncNotifierProvider<Tab2RepostioryNotifier, void>(
        Tab2RepostioryNotifier.new);
