import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab9OutputNotifier
    extends AsyncNotifier<Map<Tab9EntryModel, List<Tab9SubEntryModel>>> {
  late File pendingFile;
  @override
  FutureOr<Map<Tab9EntryModel, List<Tab9SubEntryModel>>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[9]![0];

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

  Future<void> markEntryAsComplete(Tab9EntryModel model) async {
    // TODO Inshaa Allah
  }

  Future<void> markSubEntryAsComplete(Tab9SubEntryModel model) async {
    // TODO Inshaa Allah
  }
}

final tab9OutputProvider = AsyncNotifierProvider<Tab9OutputNotifier,
    Map<Tab9EntryModel, List<Tab9SubEntryModel>>>(Tab9OutputNotifier.new);
