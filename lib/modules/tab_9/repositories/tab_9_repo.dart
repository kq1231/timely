import 'package:timely/common/entry_struct/repositories/pending_repo.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';

final tab9RepositoryProvider = NotifierProvider<
    EntryStructPendingRepositoryNotifier<Tab9EntryModel, Tab9SubEntryModel>,
    void>(() {
  return EntryStructPendingRepositoryNotifier();
});
