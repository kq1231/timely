import 'package:timely/modules/common/entry_struct/repositories/completed_repo.dart';
import 'package:timely/modules/common/entry_struct/repositories/pending_repo.dart';

class EntryStructRepositoryServiceNotifier<T, V>
    extends EntryStructPendingRepositoryNotifier<T, V> {
  Future<void> markEntryAsComplete(
      entry, List subEntries, pendingFile, completedFile) async {
    await deleteEntry(entry, pendingFile);
    await ref
        .read(completedRepositoryProvider.notifier)
        .writeEntryAsComplete(entry, subEntries, completedFile);
  }

  Future<void> markSubEntryAsComplete(
    entry,
    subEntry,
    pendingFile,
    completedFile,
  ) async {
    await deleteSubEntry(entry, subEntry, pendingFile);
    await ref
        .read(completedRepositoryProvider.notifier)
        .writeSubEntryAsComplete(entry, subEntry, completedFile);
  }
}
