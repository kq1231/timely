import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/providers/external_entries_provider.dart';
import 'package:timely/modules/tab_3/controllers/output_controller.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/services/repo_service.dart';
import 'package:timely/modules/tab_4/controllers/output_controller.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';
import 'package:timely/reusables.dart';

class Tab3InputNotifier extends Notifier<Tab3Model> {
  @override
  Tab3Model build() {
    return Tab3Model(
      text_1: "",
      priority: 1,
      time: TimeOfDay.now(),
      date: DateTime.now(),
    );
  }

  setActivity(String activity) {
    state.text_1 = activity;
  }

  setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  setTime(TimeOfDay time) {
    state = state.copyWith(time: time);
  }

  void setPriority(int index) {
    state = state.copyWith(priority: index);
  }

  void removeDateAndTime() {
    state.date = null;
    state.time = null;
  }

  Future<void> syncToDB() async {
    final file = (await ref.read(dbFilesProvider.future))[3]![0];
    state.uuid != null
        ? (state.date == null && state.time == null)
            ? await ref.read(tab4RepositoryProvider.notifier).editModel(state)
            : await ref
                .read(tab3RepositoryServiceProvider.notifier)
                .editModel(state, file)
        : await ref
            .read(tab3RepositoryServiceProvider.notifier)
            .writeModel(state, file);
    ref.invalidate(tab3OutputProvider);
    ref.invalidate(tab4OutputProvider);
    ref.invalidate(externalEntriesProvider);
  }

  void setModel(Tab3Model model) async {
    state = model;
  }
}

final tab3InputProvider =
    NotifierProvider<Tab3InputNotifier, Tab3Model>(Tab3InputNotifier.new);
