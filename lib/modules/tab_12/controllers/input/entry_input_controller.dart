import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';
import 'package:timely/modules/tab_12/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab12InputNotifier extends Notifier<Tab12EntryModel> {
  @override
  build() {
    return Tab12EntryModel(
      activity: "",
      objective: "",
      importance: 1,
      tab2Model: Tab2Model(
        name: "",
        startTime: TimeOfDay.now(),
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        dur: Duration.zero,
        every: 1,
        frequency: Frequency.daily,
        basis: Basis.day,
        repetitions: {
          "DoW": [0, 0]
        },
      ),
    );
  }

  void setActivity(String activity) =>
      state = state.copyWith(activity: activity);
  void setObjective(String objective) =>
      state = state.copyWith(objective: objective);

  void setImportance(int importance) =>
      state = state.copyWith(importance: importance);

  void setStartDate(DateTime startDate) {
    Tab2Model tab2Model = state.tab2Model.copywith(startDate: startDate);
    state = state.copyWith(tab2Model: tab2Model);
  }

  void setEndDate(DateTime endDate) {
    Tab2Model tab2Model = state.tab2Model.copywith(endDate: endDate);
    state = state.copyWith(tab2Model: tab2Model);
  }

  void setStartTime(startTime) {
    state = state.copyWith(
      tab2Model: state.tab2Model.copywith(startTime: startTime),
    );
  }

  void setEndTime(TimeOfDay endTime) {
    Duration dur = DateTime(0, 0, 0, endTime.hour, endTime.minute).difference(
        DateTime(0, 0, 0, state.tab2Model.startTime.hour,
            state.tab2Model.startTime.minute));

    state = state.copyWith(
      tab2Model: state.tab2Model.copywith(dur: dur),
    );
  }

  void setFrequency(frequency) {
    state = state.copyWith(
      tab2Model: state.tab2Model.copywith(frequency: frequency),
    );
  }

  void resetBasis() {
    Tab2Model tab2Model = state.tab2Model;
    tab2Model.basis = null;

    state = state.copyWith(tab2Model: tab2Model);
  }

  void setBasis(basis) {
    state = state.copyWith(
      tab2Model: state.tab2Model.copywith(basis: basis),
    );
  }

  void setRepetitions(Map repetitions) {
    state = state.copyWith(
      tab2Model: state.tab2Model.copywith(repetitions: repetitions),
    );
  }

  void setEvery(int every) {
    state = state.copyWith(
      tab2Model: state.tab2Model.copywith(every: every),
    );
  }

  setEntry(Tab12EntryModel model) => state = model;
  void setTab2Model(Tab2Model tab2Model) {
    state = state.copyWith(tab2Model: tab2Model);
  }

  Future<void> syncToDB(Tab12SubEntryModel subEntry) async {
    final file = (await ref.read(dbFilesProvider.future))[12]![0];

    if (state.uuid != null) {
      await ref
          .read(tab12RepositoryServiceProvider.notifier)
          .updateEntry(state, file, Tab12EntryModel.fromJson);
    } else {
      await ref
          .read(tab12RepositoryServiceProvider.notifier)
          .writeEntry(state, file, [subEntry.toJson()]);
    }

    ref.invalidate(tab12OutputProvider);
  }
}

final tab12EntryInputProvider =
    NotifierProvider<Tab12InputNotifier, Tab12EntryModel>(() {
  return Tab12InputNotifier();
});
