import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/reusables.dart';

class Tab2RepositoryNotifier extends Notifier<AsyncData<void>> {
  @override
  AsyncData<void> build() {
    return const AsyncData(null);
  }

  Future<List<Tab2Model>> fetchTab2Models() async {
    final tab3File = (await ref.read(dbFilesProvider.future)).tabTwoFile;
    List<Map> jsonContent = jsonDecode(await tab3File.readAsString());
    List<Tab2Model> models = [];
    for (Map obj in jsonContent) {
      models.add(Tab2Model.fromJson(obj));
    }

    return models;
  }

  Future<void> writeTab2Model(Tab2Model model) async {
    final tab2File = (await ref.read(dbFilesProvider.future)).tabTwoFile;
    List jsonContent = jsonDecode(await tab2File.readAsString());

    jsonContent = [...jsonContent, model.toJson()];

    await tab2File.writeAsString(jsonEncode(jsonContent));
  }
}

final tab2RepositoryProvider =
    NotifierProvider<Tab2RepositoryNotifier, AsyncData<void>>(
        Tab2RepositoryNotifier.new);
