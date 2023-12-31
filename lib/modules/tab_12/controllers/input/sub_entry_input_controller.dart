import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab12SubEntryInputNotifier extends Notifier<Tab2Model> {
  @override
  Tab2Model build() {
    return Tab2Model(
      basis: Basis.day,
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

  void setModel(Tab2Model model) {
    state = model;
  }

  Future<void> syncToDB(String entryUuid) async {
    final file = (await ref.read(dbFilesProvider.future))[12]![0];

    if (state.uuid != null) {
      await ref
          .read(tab12RepositoryServiceProvider.notifier)
          .updateSubEntry(entryUuid, state, file, Tab12EntryModel.fromJson);
    } else {
      await ref.read(tab12RepositoryServiceProvider.notifier).writeSubEntry(
            entryUuid,
            state,
            file,
            null,
            Tab12EntryModel.fromJson,
            Tab2Model.fromJson,
          );
    }

    ref.invalidate(tab12OutputProvider);
  }
}

final tab12SubEntryInputProvider =
    NotifierProvider<Tab12SubEntryInputNotifier, Tab2Model>(
        Tab12SubEntryInputNotifier.new);
