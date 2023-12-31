import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab12InputNotifier extends Notifier<Tab12EntryModel> {
  @override
  build() {
    return Tab12EntryModel(
      activity: "",
      objective: "",
      importance: 1,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
  }

  void setActivity(String activity) =>
      state = state.copyWith(activity: activity);
  void setObjective(String objective) =>
      state = state.copyWith(objective: objective);

  void setImportance(int importance) =>
      state = state.copyWith(importance: importance);
  void setStartDate(DateTime startDate) =>
      state = state.copyWith(startDate: startDate);
  void setEndDate(DateTime endDate) => state = state.copyWith(endDate: endDate);
  void setModel(model) => state = model;

  Future<void> syncToDB(Tab2Model subEntry) async {
    final file = (await ref.read(dbFilesProvider.future))[12]![0];

    if (state.uuid != null) {
      await ref
          .read(tab12RepositoryServiceProvider.notifier)
          .updateEntry(state, file, Tab12EntryModel.fromJson);
    } else {
      await ref
          .read(tab12RepositoryServiceProvider.notifier)
          .writeEntry(state, file, [subEntry]);
    }

    ref.invalidate(tab12OutputProvider);
  }
}

final tab12EntryInputProvider =
    NotifierProvider<Tab12InputNotifier, Tab12EntryModel>(() {
  return Tab12InputNotifier();
});
