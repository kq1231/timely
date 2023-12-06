import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/controllers/output_controller.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/modules/tab_2/repositories/tab_2_repo.dart';

class Tab2InputNotifier extends Notifier<Tab2Model> {
  @override
  Tab2Model build() {
    return Tab2Model(
      basis: Basis.day,
      startDate: DateTime.now(),
      name: "",
      startTime: TimeOfDay.now(),
      dur: const Duration(hours: 0, minutes: 30),
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

  void setEndTime(endTime) {
    state = state.copywith(endTime: endTime);
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
  Future<void> syncToDB() async {
    await ref.read(tab2RepositoryProvider.notifier).writeTab2Model(state);
    ref.invalidate(tab2OutputProvider);
  }

  Future<void> syncEditedModel() async {
    await ref.read(tab2RepositoryProvider.notifier).writeEditedModel(state);
    ref.invalidate(tab2OutputProvider);
  }
}

final tab2InputProvider =
    NotifierProvider<Tab2InputNotifier, Tab2Model>(Tab2InputNotifier.new);
