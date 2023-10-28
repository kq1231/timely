import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_five/models/spw.dart';
import 'package:timely/features/tab_one/controllers/db_files_provider.dart';

class TabFiveInputNotifier extends Notifier<SPWModel> {
  @override
  build() {
    return SPWModel(
      DateTime.now().toString().substring(0, 10),
      0,
      0,
      0,
      0,
    );
  }

  void setSScore(sScore) {
    state = state.copyWith(sScore: sScore);
  }

  void setPScore(pScore) {
    state = state.copyWith(pScore: pScore);
  }

  void setWScore(wScore) {
    state = state.copyWith(wScore: wScore);
  }

  void setWeight(weight) {
    state = state.copyWith(weight: double.parse(weight));
  }

  Future<void> syncToDB() async {
    File tabFiveFile = (await ref.read(dbFilesProvider.future)).tabFiveFile;
    Map jsonContent = jsonDecode(await tabFiveFile.readAsString());
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
}

final tabFiveInputProvider =
    NotifierProvider<TabFiveInputNotifier, SPWModel>(() {
  return TabFiveInputNotifier();
});
