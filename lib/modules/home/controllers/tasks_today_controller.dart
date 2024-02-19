import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/models/task_today.dart';
import 'package:timely/modules/home/providers/todays_model_maps_provider.dart';

class TasksTodayOutputNotifier extends AsyncNotifier<List<TaskToday>> {
  @override
  FutureOr<List<TaskToday>> build() async {
    List modelMaps = (await ref.read(todaysModelMapsProvider.future));

    List<TaskToday> tasksToday = [];

    for (Map modelMap in modelMaps) {
      tasksToday.add(TaskToday.fromJson(modelMap));
    }

    tasksToday.sort(
      (a, b) =>
          DateTime(0, 0, 0, a.startTime.hour, a.startTime.minute).compareTo(
        DateTime(
          0,
          0,
          0,
          b.startTime.hour,
          b.startTime.minute,
        ),
      ),
    );

    return tasksToday;
  }
}

final tasksTodayOutputProvider =
    AsyncNotifierProvider<TasksTodayOutputNotifier, List<TaskToday>>(
        TasksTodayOutputNotifier.new);
