import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/controllers/tasks_today_controller.dart';
import 'package:timely/modules/tab_3/services/repo_service.dart';

final externalModelsProvider = FutureProvider.autoDispose<List>((ref) async {
  var tasksToday = await ref.read(tasksTodayOutputProvider.future);
  var nonScheduledTasks = await ref
      .read(tab3RepositoryServiceProvider.notifier)
      .fetchNonScheduledModels();

  return [tasksToday, nonScheduledTasks];
});
