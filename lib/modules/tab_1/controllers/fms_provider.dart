import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/repositories/repo.dart';

class FMSNotifier extends FamilyNotifier<FMSModel, FMSModel> {
  @override
  FMSModel build(FMSModel arg) {
    Future.delayed(Duration.zero, () {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        incrementScores();
        syncToDB();

        List<int> statuses = [state.fStatus, state.mStatus, state.sStatus];
        // If all three statuses are "Poor" then cancel the timer
        if (statuses.toSet().length == 1 && statuses.toSet().first == 2) {
          timer.cancel();
        }
      });
    });
    return arg;
  }

  void incrementScores() {
    // Create a list that contains the current scores
    // Go through the list and the statuses
    // If status == 0, increment

    List<Duration> scores = [state.fScore, state.mScore, state.sScore];
    List<int> statuses = [state.fStatus, state.mStatus, state.sStatus];

    for (int i in Iterable.generate(3)) {
      if (statuses[i] == 0) {
        scores[i] = Duration(seconds: scores[i].inSeconds + 1); // Incremented
      }
    }

    state =
        state.copyWith(fScore: scores[0], mScore: scores[1], sScore: scores[2]);
  }

  void setFStatus(int status) {
    state = state.copyWith(fStatus: status);
    if (status == 1) // Yani, if status is "Fair"
    {
      setFPauseTime(DateTime.now());
    }
  }

  void setMStatus(int status) {
    state = state.copyWith(mStatus: status);
    if (status == 1) // Yani, if status is "Fair"
    {
      setMPauseTime(DateTime.now());
    }
  }

  void setSStatus(int status) {
    state = state.copyWith(sStatus: status);
    if (status == 1) // Yani, if status is "Fair"
    {
      setSPauseTime(DateTime.now());
    }
  }

  void setFPauseTime(DateTime time) {
    state = state.copyWith(fPauseTime: time);
  }

  void setMPauseTime(DateTime time) {
    state = state.copyWith(mPauseTime: time);
  }

  void setSPauseTime(DateTime time) {
    state = state.copyWith(sPauseTime: time);
  }

  void setNextUpdateTime(TimeOfDay time) {
    state = state.copyWith(nextUpdateTime: time);
  }

  Future<void> syncToDB() async {
    await ref.read(tab1RepositoryProvider.notifier).writeFMSModel(state);
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
