import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1_new/model.dart';
import 'package:timely/reusables.dart';

class ProgressRepositoryNotifier extends Notifier<void> {
  @override
  void build() {
    return;
  }

  // Methods
  Future<Progress> fetchTodaysProgress() async {
    File file = ref.read(dbFilesProvider).requireValue[1]![0];

    var content = jsonDecode(await file.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    return Progress.fromJson(content[dateToday]);
  }

  Future<void> generateTodaysProgressData() async {
    File file = ref.read(dbFilesProvider).requireValue[1]![0];

    var content = jsonDecode(await file.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    if (content.containsKey(dateToday)) {
      // Skip.
    }
    // If it does NOT contain today's date
    else {
      content[dateToday] =
          Progress(hours: [], points: 0, level: 1, paused: {}, stopped: [])
              .toJson();

      file.writeAsString(jsonEncode(content));
    }
  }

  Future<void> updateProgress(Progress model) async {
    File file = ref.read(dbFilesProvider).requireValue[1]![0];

    var content = jsonDecode(await file.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    content[dateToday] = model.toJson();

    file.writeAsString(jsonEncode(content));
  }

  Future<bool> incrementPointsByCheckingTime() async {
// Read the file and extract today's [Progress] model
    File file = ref.read(dbFilesProvider).requireValue[1]![0];

    var content = jsonDecode(await file.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    Progress model = Progress.fromJson(content[dateToday]);

    DateTime now = DateTime.now();

    bool incremented = false;

    // Check whether the current time is within the range 6am-10pm
    if (now.isAfter(now.copyWith(hour: 6, minute: 0, second: 0)) &&
        now.isBefore(now.copyWith(hour: 10, minute: 0, second: 0))) {
      // Check whether <hours> contains the current hour
      if (model.hours.contains(now.hour)) {
        // Skip
      }
      // Else, if it does not contain the current hour
      else {
        // If the time is 6 am
        if (now.hour == 6) {
          model = model.copyWith(points: 2);
          incremented = true;
        }
        for (String letter in "m,f,s".split(",")) {
          // If the letter is in paused or stopped
          if (model.paused.keys.contains(letter) ||
              model.stopped.contains(letter)) {
            // If the letter is paused
            if (model.paused.keys.contains(letter)) {
              // Check whether the current time minus the pause time is more than an hour
              if (now.difference(model.paused[letter]!).inMinutes > 60) {
                // If so, increment the score for this letter
                model = model.copyWith(points: model.points + 1);
                incremented = true;
              }
            }
            // If the letter is stopped
            else {
              // Do nothing.
            }
          }
          // If the letter is neither paused nor stopped
          else {
            // If the time is 6
            if (now.hour == 6) {
              // Skip
            }
            // If the time is not 6
            else {
              model = model.copyWith(points: model.points + 1);
              incremented = true;
            }
          }
        }
      }
    }
    // If the current time is out of range
    else {
      // Do nothing.
    }

    return incremented;
  }
}

final progressRepositoryProvider =
    NotifierProvider<ProgressRepositoryNotifier, void>(
        ProgressRepositoryNotifier.new);
