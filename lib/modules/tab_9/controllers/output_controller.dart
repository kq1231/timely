import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab9OutputNotifier extends AutoDisposeAsyncNotifier<
    Map<Tab9EntryModel, List<Tab9SubEntryModel>>> {
  late File pendingFile;
  late File completedFile;

  @override
  FutureOr<Map<Tab9EntryModel, List<Tab9SubEntryModel>>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[9]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[9]![1];

    final res = await ref
        .read(tab9RepositoryServiceProvider.notifier)
        .fetchEntriesAndSubEntries(pendingFile);

    return res;
  }

  Future<void> deleteEntry(Tab9EntryModel model) async => await ref
      .read(tab9RepositoryServiceProvider.notifier)
      .deleteEntry(model, pendingFile);

  Future<void> deleteSubEntry(
          String entryUuid, Tab9SubEntryModel model) async =>
      await ref
          .read(tab9RepositoryServiceProvider.notifier)
          .deleteSubEntry(entryUuid, model, pendingFile);

  Future<void> markEntryAsComplete(
      Tab9EntryModel model, List subEntries) async {
    await ref
        .read(tab9RepositoryServiceProvider.notifier)
        .markEntryAsComplete(model, pendingFile, completedFile, subEntries);
  }

  Future<void> markSubEntryAsComplete(
      Tab9EntryModel entryModel, Tab9SubEntryModel subEntryModel) async {
    await ref
        .read(tab9RepositoryServiceProvider.notifier)
        .markSubEntryAsComplete(
            entryModel, subEntryModel, pendingFile, completedFile);
  }
}

final tab9OutputProvider = AutoDisposeAsyncNotifierProvider<Tab9OutputNotifier,
    Map<Tab9EntryModel, List<Tab9SubEntryModel>>>(Tab9OutputNotifier.new);
