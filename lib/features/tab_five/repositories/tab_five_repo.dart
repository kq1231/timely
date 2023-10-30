import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_five/models/spw.dart';
import 'package:timely/public_providers/db_files_provider.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class TabFiveRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeSPWModel(SPWModel state) async {
    final tabFiveFile = (await ref.read(dbFilesProvider.future)).tabFiveFile;
    final jsonContent = jsonDecode(await tabFiveFile.readAsString());
    jsonContent[state.date] = [];
    jsonContent[state.date].add(
      [
        state.sScore,
        state.pScore,
        state.wScore,
      ],
    );
    jsonContent[state.date].add(
      state.weight,
    );
    await tabFiveFile.writeAsString(jsonEncode(jsonContent));
  }

  Future<List<SPWModel>> fetchSPWModels() async {
    final tabFiveFile = (await ref.read(dbFilesProvider.future)).tabFiveFile;
    final jsonContent = jsonDecode(await tabFiveFile.readAsString());
    final spwModels = <SPWModel>[];
    for (final date in jsonContent.keys) {
      final scores = jsonContent[date][0];
      final weight = jsonContent[date][1] as double;
      spwModels.add(SPWModel(date, scores[0], scores[1], scores[2], weight));
    }

    return spwModels;
  }
}

final tabFiveRepositoryProvider =
    NotifierProvider<TabFiveRepositoryNotifier, AsyncValue<void>>(
        TabFiveRepositoryNotifier.new);
