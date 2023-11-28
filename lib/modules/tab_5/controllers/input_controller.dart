import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_5/controllers/output_controller.dart';
import 'package:timely/modules/tab_5/models/spw.dart';
import 'package:timely/modules/tab_5/repositories/tab_five_repo.dart';

class TabFiveInputNotifier extends AutoDisposeNotifier<SPWModel> {
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

  String getFormattedDate() {
    return DateFormat("dd-MMM-yyyy").format(DateTime.now());
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
      // Skip.w
    }
  }

  Future<void> syncToDB() async {
    await ref.read(tabFiveRepositoryProvider.notifier).writeSPWModel(state);
    ref.invalidate(tabFiveFutureProvider);
  }
}

final tabFiveInputProvider =
    AutoDisposeNotifierProvider<TabFiveInputNotifier, SPWModel>(() {
  return TabFiveInputNotifier();
});
