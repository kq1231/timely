import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/common/repositories/pending_repo.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/reusables.dart';

class Tab10InputNotifier extends Notifier<Tab10Model> {
  @override
  build() {
    return Tab10Model(
      date: DateTime.now(),
      amount: 0.0,
      text_1: "",
      option: 1,
      isComplete: false,
    );
  }

  String getFormattedDate() {
    return DateFormat("dd-MMM-yyyy").format(state.date);
  }

  void setAmount(String amount) {
    try {
      state = state.copyWith(amount: double.parse(amount));
    } catch (e) {
      // Ski
    }
  }

  void setText_1(String text_1) {
    state = state.copyWith(text_1: text_1);
  }

  void setOption(int option) {
    state = state.copyWith(option: option);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void setModel(Tab10Model model) {
    state = model;
  }

  Future<void> syncToDB() async {
    final file = (await ref.read(dbFilesProvider.future))[10]![0];
    await ref.read(pendingRepositoryProvider.notifier).writeModel(state, file);
  }
}

final tab10InputProvider = NotifierProvider<Tab10InputNotifier, Tab10Model>(() {
  return Tab10InputNotifier();
});
