import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_5/models/spw.dart';
import 'package:timely/reusables.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab5RepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeSPWModel(SPWModel model) async {
    final tab5File = (await ref.read(dbFilesProvider.future))[5]![0];
    final jsonContent = jsonDecode(await tab5File.readAsString());
    jsonContent[model.date] = [];
    jsonContent[model.date].add(
      [
        model.sScore,
        model.pScore,
        model.wScore,
      ],
    );
    jsonContent[model.date].add(
      model.weight,
    );
    await tab5File.writeAsString(jsonEncode(jsonContent));
  }

  Future<List<SPWModel>> fetchSPWModels() async {
    final tab5File = (await ref.read(dbFilesProvider.future))[5]![0];
    final jsonContent = jsonDecode(await tab5File.readAsString());
    final spwModels = <SPWModel>[];
    for (final date in jsonContent.keys.toList().reversed) {
      final scores = jsonContent[date][0];
      final weight = jsonContent[date][1] as double;
      spwModels.add(
        SPWModel(date, scores[0], scores[1], scores[2], weight),
      );
    }

    return spwModels;
  }

  Future<void> deleteModel(SPWModel model) async {
    // Fetch the data
    final tab5File = (await ref.read(dbFilesProvider.future))[5]![0];
    Map jsonContent = jsonDecode(await tab5File.readAsString());

    jsonContent.removeWhere((key, value) {
      return key == model.date;
    });

    // Persist the data
    await tab5File.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> editModel(SPWModel model) async {
    await deleteModel(model);
    await writeSPWModel(model);
  }
}

final tab5RepositoryProvider =
    NotifierProvider<Tab5RepositoryNotifier, AsyncValue<void>>(
        Tab5RepositoryNotifier.new);
