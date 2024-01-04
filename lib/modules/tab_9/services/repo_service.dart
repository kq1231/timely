import 'package:timely/common/entry_struct/services/repo_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';

final tab9RepositoryServiceProvider = NotifierProvider<
    EntryStructRepositoryServiceNotifier<Tab9EntryModel, Tab9SubEntryModel>,
    void>(() {
  return EntryStructRepositoryServiceNotifier();
});
