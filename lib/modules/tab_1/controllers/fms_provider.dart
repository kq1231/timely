import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/repositories/repo.dart';

class FMSNotifier extends FamilyNotifier<FMSModel, FMSModel> {
  @override
  FMSModel build(FMSModel arg) {
    return arg;
  }

  void incrementFScore() {
    state = state.copyWith(
      fScore: Duration(seconds: state.fScore.inSeconds + 1),
    );
  }

  void incrementMScore() {
    state = state.copyWith(
      mScore: Duration(seconds: state.mScore.inSeconds + 1),
    );
  }

  void incrementSScore() {
    state = state.copyWith(
      sScore: Duration(seconds: state.sScore.inSeconds + 1),
    );
  }

  void setFStatus(int index) {
    state = state.copyWith(fStatus: index);
  }

  void setMStatus(int index) {
    state = state.copyWith(mStatus: index);
  }

  void setSStatus(int index) {
    state = state.copyWith(sStatus: index);
  }

  void setNextUpdateTime(TimeOfDay time) {
    state = state.copyWith(nextUpdateTime: time);
  }

  Future<void> syncToDB() async {
    await ref.read(tab1RepositoryProvider.notifier).writeFMSModel(state);
    ref.invalidate(remainingTimeTickerProvider);
  }

  void setModel(FMSModel model) {
    state = model;
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }
}

final fmsProvider =
    NotifierProvider.family<FMSNotifier, FMSModel, FMSModel>(() {
  return FMSNotifier();
});
