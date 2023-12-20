import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2_6_7/tab_2/controllers/output_controller.dart';
import 'package:timely/modules/tab_2_6_7/common/models/tab_2_model.dart';
import 'package:timely/modules/tab_2_6_7/common/services/repo_service.dart';
import 'package:timely/modules/tab_2_6_7/tab_6/controllers/output_controller.dart';
import 'package:timely/modules/tab_2_6_7/tab_7/controllers/output_controller.dart';
import 'package:timely/reusables.dart';

class Tab2InputNotifier extends Notifier<Tab2Model> {
  @override
  Tab2Model build() {
    return Tab2Model(
      basis: Basis.day,
      startDate: DateTime.now(),
      frequency: "Daily",
      name: "",
      startTime: TimeOfDay.now(),
      dur: const Duration(hours: 0, minutes: 0),
      repetitions: {
        "DoW": [0, 0]
      },
      every: 1,
    );
  }

  // Setters
  void setName(name) {
    state = state.copywith(name: name);
  }

  void setStartDate(date) {
    state = state.copywith(startDate: date);
  }

  void setStartTime(startTime) {
    state = state.copywith(startTime: startTime);
  }

  void setEndTime(dur) {
    state = state.copywith(dur: dur);
  }

  void setFrequency(frequency) {
    state = state.copywith(frequency: frequency);
  }

  void resetBasis() {
    state.basis = null;
  }

  void setBasis(basis) {
    state = state.copywith(basis: basis);
  }

  void setRepetitions(Map repetitions) {
    state = state.copywith(repetitions: repetitions);
  }

  void setEvery(int every) {
    state = state.copywith(every: every);
  }

  void setEndDate(endDate) {
    state = state.copywith(endDate: endDate);
  }

  void setModel(Tab2Model model) {
    state = model;
  }

  // Methods
  Future<void> syncToDB(tabNumber) async {
    final file = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    await ref.read(repositoryServiceProvider.notifier).writeModel(state, file);

    for (final provider in [
      tab2OutputProvider,
      tab6OutputProvider,
      tab7OutputProvider,
    ]) {
      ref.invalidate(provider);
    }
  }

  Future<void> syncEditedModel(tabNumber) async {
    final file = (await ref.read(dbFilesProvider.future))[tabNumber]![0];
    await ref.read(repositoryServiceProvider.notifier).editModel(state, file);

    for (final provider in [
      tab2OutputProvider,
      tab6OutputProvider,
      tab7OutputProvider,
    ]) {
      ref.invalidate(provider);
    }
  }
}

final tab2InputProvider =
    NotifierProvider<Tab2InputNotifier, Tab2Model>(Tab2InputNotifier.new);
