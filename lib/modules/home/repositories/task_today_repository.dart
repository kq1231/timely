import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/models/task_today.dart';
import 'package:timely/modules/home/providers/todays_model_maps_provider.dart';
import 'package:timely/reusables.dart';

class TasksTodayRepositoryNotifier extends Notifier<void> {
  @override
  build() {
    return;
  }

  Future<void> generateTodaysTasks() async {
    // Bismillahir Rahmanir Rahim

    // Get the file -1
    // If no key exists then add data for today's date -2
    // If keys exist then check whether the last key is today's date or not -3
    // If it isn't then add data -4

    // 1
    File tasksTodayFile = ref.read(dbFilesProvider).requireValue[0]![0];
    Map content = jsonDecode(await tasksTodayFile.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    // 2
    if (content.keys.isEmpty) {
      List models = (await ref.read(todaysModelMapsProvider.future));
      content[dateToday] = models;

      await tasksTodayFile.writeAsString(jsonEncode(content));
    }

    // 3
    else {
      if (content.keys.last != dateToday) {
        // 4
        List models = (await ref.read(todaysModelMapsProvider.future));
        content[dateToday] = models;

        await tasksTodayFile.writeAsString(jsonEncode(content));
      }
    }
  }

  Future<List<TaskToday>> fetchTodaysTasks() async {
    File tasksTodayFile = ref.read(dbFilesProvider).requireValue[0]![0];
    Map content = jsonDecode(await tasksTodayFile.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    List<TaskToday> tasksToday = [];

    for (Map modelMap in content[dateToday]) {
      tasksToday.add(TaskToday.fromJson(modelMap));
    }

    return tasksToday;
  }
}

final TasksTodayRepositoryProvider =
    NotifierProvider<TasksTodayRepositoryNotifier, void>(
        TasksTodayRepositoryNotifier.new);
