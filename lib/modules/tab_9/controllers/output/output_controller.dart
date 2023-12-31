import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/entry_struct/controllers/output/output_controller.dart';
import 'package:timely/modules/common/entry_struct/services/repo_service.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/services/repo_service.dart';

final tab9OutputProvider = AutoDisposeAsyncNotifierProvider<
    EntryStructOutputNotifier<Tab9EntryModel, Tab9SubEntryModel,
        EntryStructRepositoryServiceNotifier>,
    Map<Tab9EntryModel, List<Tab9SubEntryModel>>>(() {
  return EntryStructOutputNotifier(
      repoService: tab9RepositoryServiceProvider,
      entryModelizer: Tab9EntryModel.fromJson,
      subEntryModelizer: Tab9SubEntryModel.fromJson);
});
