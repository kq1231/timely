import 'dart:io';

import 'package:timely/common/entry_struct/services/repo_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/mixins/filter_mixin.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';

class Tab12RepositoryServiceNotifier
    extends EntryStructRepositoryServiceNotifier<Tab12EntryModel,
        Tab12SubEntryModel> with FilterMixin {
  // --------- --------- --------- --------- --------- --------- ---------

  Future<Map<Tab12EntryModel, List<Tab12SubEntryModel>>>
      fetchFilteredEntriesAndSubEntries(
    File file,
  ) async {
    Map<Tab12EntryModel, List<Tab12SubEntryModel>> entriesAndSubEntries =
        await fetchEntriesAndSubEntries(
            file, Tab12EntryModel.fromJson, Tab12SubEntryModel.fromJson);

    // We need to check the entry
    // If it falls today, then add to the filtered variable.

    Map<Tab12EntryModel, List<Tab12SubEntryModel>> filtered = {};

    for (Tab12EntryModel entry in entriesAndSubEntries.keys) {
      if (filterCurrentActivities([entry.tab2Model]).isNotEmpty) {
        filtered[entry] = entriesAndSubEntries[entry]!;
      }
    }

    return filtered;
  }
}

final tab12RepositoryServiceProvider =
    NotifierProvider<Tab12RepositoryServiceNotifier, void>(() {
  return Tab12RepositoryServiceNotifier();
});
