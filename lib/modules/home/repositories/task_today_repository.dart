import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/models/task_today.dart';
import 'package:timely/modules/home/providers/todays_model_maps_provider.dart';
import 'package:timely/reusables.dart';

// Bismillahir Rahmanir Rahim

class TasksTodayRepositoryNotifier extends Notifier<void> {
  @override
  build() {
    return;
  }

  Future<void> generateTodaysTasks() async {
    File tasksTodayFile = (await ref.read(dbFilesProvider.future))[0]![0];
    Map content = jsonDecode(await tasksTodayFile.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    List models = (await ref.read(todaysModelMapsProvider.future));
    content[dateToday] = models;

    await tasksTodayFile.writeAsString(jsonEncode(content));
  }

  // Future<void> writeModel(Map json, int tabNumber) async {
  //   File tasksTodayFile = (await ref.read(dbFilesProvider.future))[0]![0];
  //   Map content = jsonDecode(await tasksTodayFile.readAsString());

  //   String dateToday = DateTime.now().toString().substring(0, 10);

  //   if (content[dateToday].keys.contains(json["ID"])) {
  //     for (var modelMap in content[dateToday]) {
  //       if (modelMap["Data"]["ID"] == json["ID"]) {
  //         modelMap["Data"] = json;
  //         break;
  //       }
  //     }
  //   } else {
  //     content[dateToday].add({
  //       "Tab Number": tabNumber,
  //       "Data": json,
  //     });
  //   }

  //   // Persist
  //   await tasksTodayFile.writeAsString(jsonEncode(content));
  // }

  Future<List<TaskToday>> fetchTodaysTasks() async {
    File tasksTodayFile = (await ref.read(dbFilesProvider.future))[0]![0];
    Map content = jsonDecode(await tasksTodayFile.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    List<TaskToday> tasksToday = [];

    for (Map modelMap in content[dateToday]) {
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

  // Future<void> deleteModel(String id, int tabNumber) async {
  //   File tasksTodayFile = (await ref.read(dbFilesProvider.future))[0]![0];
  //   Map content = jsonDecode(await tasksTodayFile.readAsString());

  //   String dateToday = DateTime.now().toString().substring(0, 10);

  //   content[dateToday].removeWhere((modelMap) => modelMap["Data"]["ID"] == id);

  //   // Persist
  //   await tasksTodayFile.writeAsString(jsonEncode(content));
  // }
}

final tasksTodayRepositoryProvider =
    NotifierProvider<TasksTodayRepositoryNotifier, void>(
        TasksTodayRepositoryNotifier.new);
