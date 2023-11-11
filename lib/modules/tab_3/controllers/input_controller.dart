import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/controllers/output_controller.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/tab_3_repo.dart';

class Tab3InputNotifier extends Notifier<Tab3Model> {
  @override
  Tab3Model build() {
    return Tab3Model(text_1: "", priority: 0);
  }

  setActivity(String activity) {
    state.text_1 = activity;
  }

  setDate(String date) {
    state.date = date;
  }

  setTime(TimeOfDay time) {
    state.time = time;
  }

  void setPriority(int priority) {
    state.priority = priority;
    state = state;
  }

  Future<void> syncToDB() async {
    await ref.read(tab3RepositoryProvider.notifier).writeTab3Model(state);
    ref.invalidate(tab3OutputProvider);
  }
}

final tab3InputProvider =
    NotifierProvider<Tab3InputNotifier, Tab3Model>(Tab3InputNotifier.new);
