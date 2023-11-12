import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/reusables.dart';

class Tab4RepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  // Methods
  Future<void> writeTab4Model(Tab3Model model) async {
    final file = (await ref.read(dbFilesProvider.future)).tabFourFile;
    List content = jsonDecode(await file.readAsString());

    content = [
      ...content,
      {
        "Activity": model.text_1,
        "Priority": model.priority,
      },
    ];

    await file.writeAsString(jsonEncode(content));
  }

  Future<List<Tab3Model>> fetchTab4Models() async {
    final file = (await ref.read(dbFilesProvider.future)).tabFourFile;
    List content = jsonDecode(await file.readAsString());
    List<Tab3Model> models = <Tab3Model>[];

    for (Map indCon in content) {
      models.add(Tab3Model.fromJson(null, indCon));
    }
    print(models);
    return models;
  }
}

final tab4RepositoryProvider =
    NotifierProvider<Tab4RepositoryNotifier, AsyncValue<void>>(
        Tab4RepositoryNotifier.new);
