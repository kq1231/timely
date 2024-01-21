import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/modules/tab_1/controllers/output_controller.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/repositories/pending_repo.dart';

class Tab1InputNotifier extends Notifier<FMSModel> {
  @override
  FMSModel build() {
    return FMSModel(
      date: DateTime.now(),
      fScore: 1,
      mScore: 1,
      sScore: 1,
      nextUpdateTime: TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0),
      text_1: "",
    );
  }

  void setFScore(score) {
    state = state.copyWith(fScore: score);
  }

  void setMScore(score) {
    state = state.copyWith(mScore: score);
  }

  void setSScore(score) {
    state = state.copyWith(sScore: score);
  }

  void setNextUpdateTime(TimeOfDay time) {
    state = state.copyWith(nextUpdateTime: time);
  }

  void setText_1(String text_1) {
    state = state.copyWith(text_1: text_1);
  }

  Future<void> syncToDB() async {
    await ref.read(tab1PendingRepositoryProvider.notifier).writeFMSModel(state);
    ref.invalidate(tab1OutputProvider);
    ref.invalidate(remainingTimeTickerProvider);
  }

  void setModel(FMSModel model) {
    state = model;
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }
}

final tab1InputProvider =
    NotifierProvider<Tab1InputNotifier, FMSModel>(Tab1InputNotifier.new);
