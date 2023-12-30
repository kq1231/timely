import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/entry_struct/services/repo_service.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/reusables.dart';

class EntryStructOutputNotifier<T, V>
    extends AutoDisposeAsyncNotifier<Map<T, List<V>>> {
  late File pendingFile;
  late File completedFile;
  final NotifierProvider<EntryStructRepositoryServiceNotifier<T, V>, void>
      repoService;
  final Function entryModelizer;
  final Function subEntryModelizer;

  EntryStructOutputNotifier({
    required this.repoService,
    required this.entryModelizer,
    required this.subEntryModelizer,
  });

  @override
  FutureOr<Map<T, List<V>>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[9]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[9]![1];

    return (await ref.read(repoService.notifier).fetchEntriesAndSubEntries(
        pendingFile, entryModelizer, subEntryModelizer));
  }

  Future<void> deleteEntry(Tab9EntryModel model) async =>
      await ref.read(repoService.notifier).deleteEntry(model, pendingFile);

  Future<void> deleteSubEntry(
          String entryUuid, Tab9SubEntryModel model) async =>
      await ref
          .read(repoService.notifier)
          .deleteSubEntry(entryUuid, model, pendingFile);

  Future<void> markEntryAsComplete(
      Tab9EntryModel entry, List<Tab9SubEntryModel> subEntries) async {
    await ref.read(repoService.notifier).markEntryAsComplete(
          entry,
          subEntries,
          pendingFile,
          completedFile,
        );
  }

  Future<void> markSubEntryAsComplete(
      Tab9EntryModel entryModel, Tab9SubEntryModel subEntryModel) async {
    await ref.read(repoService.notifier).markSubEntryAsComplete(
          entryModel,
          subEntryModel,
          pendingFile,
          completedFile,
        );
  }
}
