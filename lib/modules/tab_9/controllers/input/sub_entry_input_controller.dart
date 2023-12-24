import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_9/controllers/output_controller.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab9SubEntryInputNotifier extends Notifier<Tab9SubEntryModel> {
  @override
  build() {
    return Tab9SubEntryModel(
      date: DateTime.now(),
      time: "",
      task: "",
      description: "",
    );
  }

  void setDate(DateTime date) => state = state.copyWith(date: date);
  void setTime(String time) => state = state.copyWith(time: time);
  void setTask(String task) => state = state.copyWith(task: task);
  void setDescription(String description) =>
      state = state.copyWith(description: description);
  String getFormattedDate() =>
      DateFormat(DateFormat.ABBR_MONTH_DAY).format(state.date);

  Future<void> syncToDB(String entryUuid) async {
    final file = (await ref.read(dbFilesProvider.future))[9]![0];

    if (state.uuid != null) {
      await ref
          .read(tab9RepositoryServiceProvider.notifier)
          .updateSubEntry(entryUuid, state, file);
    } else {
      await ref
          .read(tab9RepositoryServiceProvider.notifier)
          .writeSubEntry(entryUuid, state, file);
    }

    ref.invalidate(tab9OutputProvider);
  }
}

final tab9SubEntryInputProvider =
    NotifierProvider<Tab9SubEntryInputNotifier, Tab9SubEntryModel>(() {
  return Tab9SubEntryInputNotifier();
});
