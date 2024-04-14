import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/repositories/tab_3_repo.dart';

final externalModelsProvider = FutureProvider.autoDispose<List>((ref) async {
  var nonScheduledTasks =
      await ref.read(tab3RepositoryProvider.notifier).fetchNonScheduledModels();

  return [nonScheduledTasks];
});
