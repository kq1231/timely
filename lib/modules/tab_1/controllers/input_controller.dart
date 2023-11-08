import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_1/controllers/output_controller.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/repositories/tab_one_repo.dart';

class TabOneInputNotifier extends Notifier<FMSModel> {
  @override
  FMSModel build() {
    return FMSModel(
      date: DateFormat("dd-MMM-yyyy").format(DateTime.now()),
      fScore: 0,
      mScore: 0,
      sScore: 0,
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
    await ref.read(tabOneRepositoryProvider.notifier).writeFMSModel(state);
    ref.invalidate(tabOneFutureProvider);
  }
}

final tabOneInputProvider =
    NotifierProvider<TabOneInputNotifier, FMSModel>(TabOneInputNotifier.new);
