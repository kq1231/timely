import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/tab_3_repo_impl.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';
import 'package:timely/reusables.dart';
import 'package:uuid/uuid.dart';

class Tab3Notifier extends Notifier<AsyncValue<void>>
    implements Tab3RepositorySkeleton {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  @override
  Future<Map<String, List<Tab3Model>>> fetchTab3Models() async {
    final tab3File = (await ref.read(dbFilesProvider.future)).tab3File;
    final jsonContent = jsonDecode(await tab3File.readAsString());
    final dates = jsonContent.keys.toList();
    Map<String, List<Tab3Model>> tab3Models = {};
    for (String date in dates) {
      tab3Models[date] = [];
      for (Map content in jsonContent[date]) {
        tab3Models[date]!.add(Tab3Model.fromJson(date, content));
      }
    }
    return tab3Models;
  }

  @override
  Future<void> writeTab3Model(Tab3Model model) async {
    final tab3File = (await ref.read(dbFilesProvider.future)).tab3File;
    final jsonContent = jsonDecode(await tab3File.readAsString());
    if (model.date != null) {
      if (!jsonContent.keys.contains(model.date)) {
        jsonContent[model.date] = [];
      }

      if (model.time != null) {
        jsonContent[model.date] = [
          ...jsonContent[model.date], // -> Existing data
          // New data:
          {
            "ID": const Uuid().v4(),
            "Activity": model.text_1,
            "Time": "${model.time!.hour}: ${model.time!.minute}",
            "Priority": model.priority
          }
        ];
      } else {
        ref.read(tab4RepositoryProvider.notifier).writeTab4Model(model);
      }
    } else {
      ref.read(tab4RepositoryProvider.notifier).writeTab4Model(model);
    }

    await tab3File.writeAsString(jsonEncode(jsonContent));
  }

  @override
  Future<void> deleteModel(Tab3Model model) async {
    // Fetch the data
    final tab3File = (await ref.read(dbFilesProvider.future)).tab3File;
    Map jsonContent = jsonDecode(await tab3File.readAsString());

    // Loop through the dates
    // Delete the model from the data if model.uuid == $model.uuid
    for (String date in jsonContent.keys) {
      jsonContent[date].removeWhere((modelMap) {
        modelMap["ID"] == model.uuid;
        // Remove the date entirely if it is empty
        if (jsonContent[date] == []) {
          jsonContent.remove(date);
        }
      });
    }

    // Persist the data
    await tab3File.writeAsString(jsonEncode(jsonContent));
  }

  @override
  Future<void> editModel(Tab3Model model) async {
    await deleteModel(model);
    await writeTab3Model(model);
  }
}

final tab3RepositoryProvider =
    NotifierProvider<Tab3Notifier, AsyncValue<void>>(Tab3Notifier.new);
