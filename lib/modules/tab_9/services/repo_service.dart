import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/repositories/repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tab9RepositoryServiceNotifier extends RepositoryNotifier {
  Future<void> markEntryAsComplete(
      Tab9EntryModel model, pendingFile, completedFile, List subEntries) async {
    // Delete entry from pending and add it to completed.
    await deleteEntry(model, pendingFile);
    await writeEntry(model, completedFile, subEntries);
  }

  Future<void> markSubEntryAsComplete(Tab9EntryModel entryModel,
      Tab9SubEntryModel model, pendingFile, completedFile) async {
    // Delete sub-entry from pending and add it to completed.
    await deleteSubEntry(entryModel.uuid!, model, pendingFile);
    await writeSubEntry(entryModel.uuid!, model, completedFile, entryModel);
  }
}

final tab9RepositoryServiceProvider =
    NotifierProvider<Tab9RepositoryServiceNotifier, void>(
        Tab9RepositoryServiceNotifier.new);
