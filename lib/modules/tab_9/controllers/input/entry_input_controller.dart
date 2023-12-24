import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/controllers/output_controller.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab10InputNotifier extends Notifier<Tab9EntryModel> {
  @override
  build() {
    return const Tab9EntryModel(
      condition: "condition",
      criticality: 0,
      care: "care",
      lessonLearnt: "lessonLearnt",
    );
  }

  void setCondition(String condition) => state.copyWith(condition: condition);
  void setCriticality(int criticality) =>
      state.copyWith(criticality: criticality);
  void setCare(String care) => state.copyWith(care: care);
  void setLessonLearnt(String lessonLearnt) =>
      state.copyWith(lessonLearnt: lessonLearnt);

  Future<void> syncToDB() async {
    final file = (await ref.read(dbFilesProvider.future))[9]![0];

    if (state.uuid != null) {
      await ref
          .read(tab9RepositoryServiceProvider.notifier)
          .updateEntry(state, file);
    } else {
      await ref
          .read(tab9RepositoryServiceProvider.notifier)
          .writeEntry(state, file);
    }

    ref.invalidate(tab9OutputProvider);
  }
}

final tab10InputProvider =
    NotifierProvider<Tab10InputNotifier, Tab9EntryModel>(() {
  return Tab10InputNotifier();
});
