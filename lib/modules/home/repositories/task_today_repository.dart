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
<<<<<<< HEAD
    // If keys exist then check whether any model is deleted -3
    // If it isn't then add data -4

    // 1
    File tasksTodayFile = (await ref.read(dbFilesProvider.future))[0]![0];
=======
    // If keys exist then check whether the last key is today's date or not -3
    // If it isn't then add data -4

    // 1
    File tasksTodayFile = ref.read(dbFilesProvider).requireValue[0]![0];
>>>>>>> e04da1c (Repository Completed)
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
<<<<<<< HEAD
      // 4
      List models = (await ref.read(todaysModelMapsProvider.future));
      if (models.length !=
          content[dateToday].length) // Check if any model is deleted
      {
=======
      if (content.keys.last != dateToday) {
        // 4
        List models = (await ref.read(todaysModelMapsProvider.future));
>>>>>>> e04da1c (Repository Completed)
        content[dateToday] = models;

        await tasksTodayFile.writeAsString(jsonEncode(content));
      }
    }
  }

<<<<<<< HEAD
  Future<void> writeModel(dynamic model, int tabNumber) async {
    File tasksTodayFile = (await ref.read(dbFilesProvider.future))[0]![0];
    Map content = jsonDecode(await tasksTodayFile.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    content[dateToday].add({
      "Tab Number": tabNumber,
      "Data": model.toJson(),
    });
  }

  Future<List<TaskToday>> fetchTodaysTasks() async {
    File tasksTodayFile = (await ref.read(dbFilesProvider.future))[0]![0];
=======
  Future<List<TaskToday>> fetchTodaysTasks() async {
    File tasksTodayFile = ref.read(dbFilesProvider).requireValue[0]![0];
>>>>>>> e04da1c (Repository Completed)
    Map content = jsonDecode(await tasksTodayFile.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    List<TaskToday> tasksToday = [];

    for (Map modelMap in content[dateToday]) {
      tasksToday.add(TaskToday.fromJson(modelMap));
    }

    return tasksToday;
  }
}

<<<<<<< HEAD
final tasksTodayRepositoryProvider =
=======
final TasksTodayRepositoryProvider =
>>>>>>> e04da1c (Repository Completed)
    NotifierProvider<TasksTodayRepositoryNotifier, void>(
        TasksTodayRepositoryNotifier.new);
