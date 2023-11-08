import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_5/models/spw.dart';
import 'package:timely/reusables.dart';

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
    for (final date in jsonContent.keys.toList().reversed) {
      final scores = jsonContent[date][0];
      final weight = jsonContent[date][1] as double;
      spwModels.add(SPWModel(DateFormat('dd-MMM').format(DateTime.parse(date)),
          scores[0], scores[1], scores[2], weight));
    }

    return spwModels;
  }
}

final tabFiveRepositoryProvider =
    NotifierProvider<TabFiveRepositoryNotifier, AsyncValue<void>>(
        TabFiveRepositoryNotifier.new);
