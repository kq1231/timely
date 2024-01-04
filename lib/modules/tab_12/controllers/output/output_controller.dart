import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/entry_struct/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';
import 'package:timely/modules/tab_12/services/repo_service.dart';
import 'package:timely/reusables.dart';

class Tab12OutputNotifier extends EntryStructOutputNotifier<Tab12EntryModel,
    Tab12SubEntryModel, Tab12RepositoryServiceNotifier> {
  Tab12OutputNotifier(
      {required super.repoService,
      required super.entryModelizer,
      required super.subEntryModelizer});

  @override
  FutureOr<Map<Tab12EntryModel, List<Tab12SubEntryModel>>> build() async {
    pendingFile = (await ref.read(dbFilesProvider.future))[12]![0];
    completedFile = (await ref.read(dbFilesProvider.future))[12]![1];

    Map<Tab12EntryModel, List<Tab12SubEntryModel>> res = (await ref
        .read(repoService.notifier)
        .fetchEntriesAndSubEntries(pendingFile, Tab12EntryModel.fromJson,
            Tab12SubEntryModel.fromJson));

    return res;
  }
}

final tab12OutputProvider = AutoDisposeAsyncNotifierProvider<
    Tab12OutputNotifier, Map<Tab12EntryModel, List<Tab12SubEntryModel>>>(() {
  return Tab12OutputNotifier(
    repoService: tab12RepositoryServiceProvider,
    entryModelizer: Tab12EntryModel.fromJson,
    subEntryModelizer: Tab12SubEntryModel.fromJson,
  );
});
