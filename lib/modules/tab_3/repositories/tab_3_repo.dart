import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/tab_3_repo_impl.dart';
import 'package:timely/reusables.dart';

class Tab3Notifier extends Notifier<AsyncValue<void>>
    implements Tab3RepositorySkeleton {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  @override
  Future<List<Tab3Model>> fetchTab3Models() async {
    final tab3File = (await ref.read(dbFilesProvider.future)).tabThreeFile;
    final jsonContent = jsonDecode(await tab3File.readAsString());
    final tab3Models = <Tab3Model>[];
    String dateToday = DateTime.now().toString().substring(0, 10);
    for (Map model in jsonContent[dateToday]) {
      tab3Models.add(Tab3Model.fromJson(dateToday, model));
    }
    return tab3Models;
  }

  @override
  Future<void> writeTab3Model(Tab3Model model) async {
    final tab3File = (await ref.read(dbFilesProvider.future)).tabThreeFile;
    final jsonContent = jsonDecode(await tab3File.readAsString());
    if ()
    if (!jsonContent.keys.contains(model.date)) {
      jsonContent[model.date] = [];
    }

    jsonContent[model.date] = [
      ...jsonContent[model.date], // -> Existing data
      // New data:
      {
        "Activity": model.text_1,
        "Time": "${model.time.hour}: ${model.time.minute}",
        "Priority": model.priority
      }
    ];

    await tab3File.writeAsString(jsonEncode(jsonContent));
  }
}

final tab3RepositoryProvider =
    NotifierProvider<Tab3Notifier, AsyncValue<void>>(Tab3Notifier.new);
