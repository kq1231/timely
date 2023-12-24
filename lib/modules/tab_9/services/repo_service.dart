import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/repositories/repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tab9RepositoryServiceNotifier extends RepositoryNotifier {
  Future<void> markEntryAsComplete(
      Tab9EntryModel model, pendingFile, completedFile) async {
    // Delete entry from pending and add it to completed.
    await deleteEntry(model, pendingFile);
    await writeEntry(model, completedFile);
  }

  Future<void> markSubEntryAsComplete(String entryUuid, Tab9SubEntryModel model,
      pendingFile, completedFile) async {
    // Delete sub-entry from pending and add it to completed.
    await deleteSubEntry(entryUuid, model, pendingFile);
    await writeSubEntry(model, completedFile);
  }
}

final tab9RepositoryServiceProvider =
    NotifierProvider<Tab9RepositoryServiceNotifier, void>(
        Tab9RepositoryServiceNotifier.new);
