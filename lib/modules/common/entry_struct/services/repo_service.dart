import 'package:timely/modules/common/entry_struct/repositories/completed_repo.dart';
import 'package:timely/modules/common/entry_struct/repositories/pending_repo.dart';

class EntryStructRepositoryServiceNotifier<T, V>
    extends PendingRepositoryNotifier<T, V> {
  Future<void> markEntryAsComplete(
      entry, List subEntries, pendingFile, completedFile) async {
    await deleteEntry(entry, pendingFile);
    await ref
        .read(completedRepositoryProvider.notifier)
        .writeEntryAsComplete(entry, subEntries, completedFile);
  }

  Future<void> markSubEntryAsComplete(
    entryModel,
    model,
    pendingFile,
    completedFile,
    entryModelizer,
    subEntryModelizer,
  ) async {
    // Delete sub-entry from pending and add it to completed.
    await deleteSubEntry(entryModel.uuid!, model, pendingFile, entryModelizer);
    await writeSubEntry(
      entryModel.uuid!,
      model,
      completedFile,
      entryModel,
      entryModelizer,
      subEntryModelizer,
    );
  }
}
