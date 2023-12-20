import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/services/repo_service.dart';
import 'package:timely/modules/tab_2_6_7/common/models/tab_2_model.dart';
import 'package:timely/reusables.dart';

class Tab2RepostioryNotifier<T> extends RepositoryService<Tab2Model> {
  Future<List> getActivitiesForToday(Function modelizer, File file) async {
    // Functions for DRYness
    List<int> getOccurences(
        Tab2Model model, int ordinalPosition, int dayOfWeek) {
      List<int> occurences = [];

      // Get all occurences of $day
      int firstOccurence = 0;
      int num = 0;
      while (true) {
        num++;
        if (DateTime(DateTime.now().year, DateTime.now().month, num).weekday ==
            (dayOfWeek + 1)) {
          firstOccurence = num - 1; // As index.
          break;
        }
      }
      num = 0;
      while (true) {
        num++;
        if ((firstOccurence + 1) + (7 * num) < 31) {
          occurences.add((firstOccurence + 1) + (7 * num));
        } else {
          break;
        }
      }
      return [firstOccurence, ...occurences];
    }

    List<Map> checkWithOrdinalPosition(List<int> occurences,
        int ordinalPosition, Tab2Model model, List<Map> currentModels) {
      try {
        if (ordinalPosition != 5) {
          if (DateTime.now().day == occurences[ordinalPosition]) {
            currentModels.add(model.toJson());
          }
        } else {
          if (DateTime.now().day == occurences.last) {
            currentModels.add(model.toJson());
          }
        }
      } catch (e) {
        // Skip it.
      }
      return currentModels;
    }

    // Get the models
    List models = await fetchModels(modelizer, file);

    // Create an array of selected models
    List<Map> currentModels = [];

    // Compare the dates in different cases
    for (Tab2Model model in models) {
      // Today's date and time
      DateTime dateToday = DateTime.now();

      if (model.endDate == null ||
          !(model.endDate ?? dateToday).isBefore(dateToday)) {
        switch (model.frequency) {
          case "Daily":
            if (dateToday.difference(model.startDate).inDays % model.every ==
                0) {
              currentModels.add(model.toJson());
            }
            break;

          case "Weekly":
            // Formula:
            // ceil((D2 - D1 + Weekday index of the first day of month D1 + 1) / 7) - 1
            int firstDayIndex = model.startDate.copyWith(day: 1).weekday - 1;
            int weekNumber = ((dateToday.difference(model.startDate).inDays +
                            1 +
                            firstDayIndex) /
                        7)
                    .ceil() -
                1;
            List weekdays = model.repetitions["Weekdays"];

            if (weekNumber % model.every == 0) {
              if (weekdays.contains(dateToday.weekday - 1)) {
                currentModels.add(model.toJson());
              }
            }
            break;

          case "Monthly":
            // Formula: (M2 - M1) + (Y2 - Y1) * 12
            int monthNumber = (dateToday.month - model.startDate.month) +
                (dateToday.year - model.startDate.year) * 12;
            if (monthNumber % model.every == 0) {
              if (model.basis == Basis.day) {
                int ordinalPosition = model.repetitions["DoW"][0];
                int dayOfWeek = model.repetitions["DoW"][1];
                List<int> occurences =
                    getOccurences(model, ordinalPosition, dayOfWeek);

                // Check with ordinal position and today's date
                currentModels = checkWithOrdinalPosition(
                    occurences, ordinalPosition, model, currentModels);

                // Check for Basis.date
              } else if (model.basis == Basis.date) {
                if (model.repetitions["Dates"].contains(dateToday.day)) {
                  currentModels.add(model.toJson());
                }
              }
            }

          case "Yearly":
            // Formula: (Y2 - Y1)
            int yearNumber = dateToday.year - model.startDate.year;
            if (yearNumber % model.every == 0) {
              if (model.basis == Basis.day) {
                // Check if the current month exists inside $Months
                if (model.repetitions["Months"].contains(dateToday.month)) {
                  int ordinalPosition = model.repetitions["DoW"][0];
                  int dayOfWeek = model.repetitions["DoW"][1];

                  List<int> occurences =
                      getOccurences(model, ordinalPosition, dayOfWeek);

                  // Check with ordinal position and today's date
                  currentModels = checkWithOrdinalPosition(
                      occurences, ordinalPosition, model, currentModels);
                }
              } else if (model.basis == Basis.date) {
                if (model.repetitions["Months"].contains(dateToday.month)) {
                  currentModels.add(model.toJson());
                }
              }
            }

          default:
            break;
        }
      }
    }
    return currentModels;
  }

  Future<void> generateActivitiesForToday(Function modelizer, File file) async {
    // Grab the file
    final currentActivitiesFile =
        (await ref.read(dbFilesProvider.future))[2]!.last;

    // Save to the file
    await currentActivitiesFile.writeAsString(
        jsonEncode(await getActivitiesForToday(modelizer, file)));
  }
}

final repositoryServiceProvider =
    NotifierProvider<Tab2RepostioryNotifier<Tab2Model>, void>(
        Tab2RepostioryNotifier.new);
