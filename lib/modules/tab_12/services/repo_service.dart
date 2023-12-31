import 'dart:io';

import 'package:timely/modules/common/entry_struct/services/repo_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/scheduling/mixins/filter_mixin.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';

class Tab12RepositoryServiceNotifier
    extends EntryStructRepositoryServiceNotifier<Tab12EntryModel, Tab2Model>
    with FilterMixin {
  Future<Map<Tab12EntryModel, List<Tab2Model>>>
      fetchFilteredEntriesAndSubEntries(
    File file,
  ) async {
    Map<Tab12EntryModel, List<Tab2Model>> entriesAndSubEntries =
        await fetchEntriesAndSubEntries(
            file, Tab12EntryModel.fromJson, Tab2Model.fromJson);

    // We need to check the last sub-entry
    // If it falls today, then add to the filtered variable.

    Map<Tab12EntryModel, List<Tab2Model>> filtered = {};

    for (Tab12EntryModel entry in entriesAndSubEntries.keys) {
      Tab2Model lastSubEntry = entriesAndSubEntries[entry]!.last;
      if (filterCurrentActivities([lastSubEntry]).isNotEmpty) {
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
