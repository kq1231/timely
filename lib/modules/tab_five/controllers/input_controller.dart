import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_five/models/spw.dart';
import 'package:timely/modules/tab_five/repositories/tab_five_repo.dart';

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
    try {
      state = state.copyWith(weight: double.parse(weight));
    } catch (e) {
      print(e);
    }
  }

  Future<void> syncToDB() async {
    ref.read(tabFiveRepositoryProvider.notifier).writeSPWModel(state);
  }
}

final tabFiveInputProvider =
    NotifierProvider<TabFiveInputNotifier, SPWModel>(() {
  return TabFiveInputNotifier();
});
