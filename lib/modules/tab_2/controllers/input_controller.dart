import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/modules/tab_2/repositories/tab_2_repo.dart';

class Tab2InputNotifier extends AutoDisposeNotifier<Tab2Model> {
  @override
  Tab2Model build() {
    return Tab2Model(
      startDate: DateTime.now(),
      name: "",
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now(),
      frequency: Frequency.monthly,
      basis: Basis.day,
      repetitions: [0, 0],
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

  void setBasis(basis) {
    state = state.copywith(basis: basis);
  }

  void setRepetitions(repetitions) {
    state = state.copywith(repetitions: repetitions);
  }

  void setEndDate(endDate) {
    state = state.copywith(endDate: endDate);
  }

  // Methods
  Future<void> syncToDB() async {
    await ref.read(tab2RepositoryProvider.notifier).writeTab2Model(state);
  }
}

final tab2InputProvider =
    AutoDisposeNotifierProvider<Tab2InputNotifier, Tab2Model>(
        Tab2InputNotifier.new);
