import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1_new/model.dart';
import 'package:timely/modules/tab_1_new/repository.dart';

class ProgressModelNotifier extends AsyncNotifier<Progress> {
  @override
  FutureOr<Progress> build() async {
    return ref.read(progressRepositoryProvider.notifier).fetchTodaysProgress();
  }

  // Methods
  void pause(String letter) {
    Map<String, DateTime> paused = state.requireValue.paused;
    paused.addAll({letter: DateTime.now()});
    ref
        .read(progressRepositoryProvider.notifier)
        .updateProgress(state.requireValue.copyWith(paused: paused));
  }
}

final progressModelProvider =
    AsyncNotifierProvider<ProgressModelNotifier, Progress>(
        ProgressModelNotifier.new);
