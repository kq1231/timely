import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/controllers/output_controller.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab9InputNotifier extends Notifier<Tab9EntryModel> {
  @override
  build() {
    return const Tab9EntryModel(
      condition: "",
      criticality: 0,
      care: "",
      lessonLearnt: "",
    );
  }

  void setCondition(String condition) =>
      state = state.copyWith(condition: condition);
  void setCriticality(String criticality) {
    try {
      state = state.copyWith(criticality: int.parse(criticality));
    } catch (e) {
      // Skip
    }
  }

  void setCare(String care) => state = state.copyWith(care: care);
  void setLessonLearnt(String lessonLearnt) =>
      state = state.copyWith(lessonLearnt: lessonLearnt);
  void setModel(model) => state = model;

  Future<void> syncToDB() async {
    final file = (await ref.read(dbFilesProvider.future))[9]![0];

    if (state.uuid != null) {
      await ref
          .read(tab9RepositoryServiceProvider.notifier)
          .updateEntry(state, file);
    } else {
      await ref
          .read(tab9RepositoryServiceProvider.notifier)
          .writeEntry(state, file, null);
    }

    ref.invalidate(tab9OutputProvider);
  }
}

final tab9EntryInputProvider =
    NotifierProvider<Tab9InputNotifier, Tab9EntryModel>(() {
  return Tab9InputNotifier();
});
