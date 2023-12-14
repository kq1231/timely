import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_10/controllers/output_controller.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/modules/tab_10/repositories/completed_repo.dart';
import 'package:timely/modules/tab_10/repositories/pending_repo.dart';

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
    if (state.uuid != null) {
      ref.read(tab10PendingRepositoryProvider.notifier).editModel(state);
    } else {
      await ref
          .read(tab10PendingRepositoryProvider.notifier)
          .writeTab10Model(state);
    }

    ref.invalidate(tab10OutputProvider);
  }

  Future<void> markAsComplete() async {
    // Shift the model from pending DB to completed DB and refresh immediately
    // after model is removed from pending DB.
    await ref.read(tab10PendingRepositoryProvider.notifier).deleteModel(state);
    ref.invalidate(tab10OutputProvider);

    await ref
        .read(tab10CompletedRepositoryProvider.notifier)
        .writeTab10ModelAsComplete(state);
  }
}

final tab10InputProvider = NotifierProvider<Tab10InputNotifier, Tab10Model>(() {
  return Tab10InputNotifier();
});
