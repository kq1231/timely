import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/modules/tab_1/controllers/output_controller.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/repositories/tab_one_repo.dart';

class Tab1InputNotifier extends Notifier<FMSModel> {
  @override
  FMSModel build() {
    return FMSModel(
      date: DateTime.now().toString().substring(0, 10),
      fScore: 0,
      mScore: 0,
      sScore: 0,
      nextUpdateTime: TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0),
      text_1: "",
    );
  }

  String getFormattedDate() {
    return DateFormat("dd-MMM-yyyy").format(DateTime.parse(state.date));
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
    await ref.read(tab1RepositoryProvider.notifier).writeFMSModel(state);
    ref.invalidate(tab1FutureProvider);
    ref.invalidate(remainingTimeTickerProvider);
  }

  void setModel(FMSModel model) {
    state = model;
  }
}

final tab1InputProvider =
    NotifierProvider<Tab1InputNotifier, FMSModel>(Tab1InputNotifier.new);
