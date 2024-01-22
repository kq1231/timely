import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';
import 'package:timely/reusables.dart';

class Tab3RepositoryNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<Map<String, List<Tab3Model>>> fetchModels(file) async {
    final tab3File = (await ref.read(dbFilesProvider.future))[3]![0];
    final jsonContent = jsonDecode(await tab3File.readAsString());
    final dates = jsonContent.keys.toList();
    Map<String, List<Tab3Model>> tab3Models = {};
    for (String date in dates) {
      tab3Models[date] = [];
      for (Map content in jsonContent[date]) {
        tab3Models[date]!.add(
          Tab3Model.fromJson(
            DateTime.parse(date),
            content,
          ),
        );
      }
    }
    return tab3Models;
  }

  Future<void> writeModel(Tab3Model model, file) async {
    final tab3File = (await ref.read(dbFilesProvider.future))[3]![0];
    final jsonContent = jsonDecode(await tab3File.readAsString());

    if (model.date != null) {
      String date = model.date.toString().substring(0, 10);
      if (!jsonContent.keys.contains(date)) {
        jsonContent[date] = [];
      }

      if (model.time != null) {
        jsonContent[date] = [
          ...jsonContent[date], // -> Existing data
          // New data:
          model.toJson(),
        ];
      } else {
        ref.read(tab4RepositoryProvider.notifier).writeModel(model);
      }
    } else {
      ref.read(tab4RepositoryProvider.notifier).writeModel(model);
    }

    await tab3File.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> deleteModel(Tab3Model model, file) async {
    // Fetch the data
    final tab3File = (await ref.read(dbFilesProvider.future))[3]![0];
    Map jsonContent = jsonDecode(await tab3File.readAsString());

    // Loop through the dates
    // Delete the model from the data if model.uuid == $model.uuid
    for (String date in jsonContent.keys) {
      jsonContent[date].removeWhere((modelMap) {
        return modelMap["ID"] == model.uuid;
      });
    }

    // Remove the date entirely if it is empty
    jsonContent.removeWhere((key, value) => value.length == 0);

    // Persist the data
    await tab3File.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> editModel(Tab3Model model, file) async {
    await deleteModel(model, file);
    await writeModel(model, file);
  }
}
