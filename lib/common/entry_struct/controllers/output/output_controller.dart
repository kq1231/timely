import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/entry_struct/repositories/pending_repo.dart';
import 'package:timely/reusables.dart';

class EntryStructOutputNotifier<T, V,
        U extends EntryStructPendingRepositoryNotifier<T, V>>
    extends AutoDisposeAsyncNotifier<Map<T, List<V>>> {
  late File pendingFile;
  late File completedFile;
  final NotifierProvider<U, void> repoService;
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

  Future<void> deleteEntry(T model) async =>
      await ref.read(repoService.notifier).deleteEntry(model, pendingFile);

  Future<void> deleteSubEntry(String entryUuid, V model) async => await ref
      .read(repoService.notifier)
      .deleteSubEntry(entryUuid, model, pendingFile);

  Future<void> markEntryAsComplete(T entry, List<V> subEntries) async {}

  Future<void> markSubEntryAsComplete(T entryModel, V subEntryModel) async {}
}
