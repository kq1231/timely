import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/reusables.dart';

class Tab1PendingRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncValue.data(null);
  }

  Future<List<FMSModel>> fetchFMSModels() async {
    final tab1File = (await ref.read(dbFilesProvider.future))[1]![0];
    final jsonContent = jsonDecode(await tab1File.readAsString());
    final fmsModels = <FMSModel>[];
    List dates = jsonContent.keys.toList();
    dates.sort();
    dates = dates.reversed.toList();
    for (final date in dates) {
      fmsModels.add(FMSModel.fromJson({date: jsonContent[date]}));
    }

    return fmsModels;
  }

  Future<void> writeFMSModel(FMSModel model) async {
    final tab1File = (await ref.read(dbFilesProvider.future))[1]![0];
    Map jsonContent = jsonDecode(await tab1File.readAsString());
    jsonContent = {...jsonContent, ...model.toJson()};
    await tab1File.writeAsString(jsonEncode(jsonContent));
  }

  Future<void> createDefaultEntry() async {
    final tab1File = (await ref.read(dbFilesProvider.future))[1]![0];
    final jsonContent = jsonDecode(await tab1File.readAsString());
    DateTime dateToday = DateTime.now();
    DateTime currentTime = DateTime.now();
    TimeOfDay nextUpdateTime = const TimeOfDay(hour: 6, minute: 0);
    if (currentTime.hour > 6) {
      nextUpdateTime = TimeOfDay(hour: currentTime.hour + 1, minute: 0);
    }
    if (!(jsonContent.keys.toList().contains(dateToday))) {
      await writeFMSModel(FMSModel(
          date: dateToday,
          fScore: 0,
          mScore: 0,
          sScore: 0,
          text_1: "",
          nextUpdateTime: nextUpdateTime));
    }
  }

  Future<void> updateNextUpdateTime() async {
    await createDefaultEntry();
    final tab1File = (await ref.read(dbFilesProvider.future))[1]![0];
    final jsonContent = jsonDecode(await tab1File.readAsString());
    String dateToday = DateTime.now().toString().substring(0, 10);
    FMSModel model = FMSModel.fromJson({dateToday: jsonContent[dateToday]});
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      DateTime currentTime = DateTime.now();
      DateTime nextUpdateTime = DateFormat("yyyy-MM-dd HH:mm").parse(
          "$dateToday ${model.nextUpdateTime.hour}:${model.nextUpdateTime.minute}");
      if (nextUpdateTime.difference(currentTime).inMinutes <= 0) {
        model.nextUpdateTime =
            TimeOfDay(hour: model.nextUpdateTime.hour + 1, minute: 0);
        await writeFMSModel(model);
        ref.invalidate(remainingTimeTickerProvider);
      }

      if (currentTime.hour >= 10) {
        timer.cancel();
      }
    });
  }

  Future<void> deleteModel(FMSModel model) async {
    // Fetch the models
    final tab1File = (await ref.read(dbFilesProvider.future))[1]![0];
    Map jsonContent = jsonDecode(await tab1File.readAsString());

    // Loop through the map's items
    // Delete if $model.date matches the date of the map item
    for (String date in jsonContent.keys) {
      if (date == model.date) {
        jsonContent.removeWhere((key, value) => key == date);
        break;
      }
    }

    // Persist the data
    tab1File.writeAsString(jsonEncode(jsonContent));
  }
}

final tab1PendingRepositoryProvider =
    NotifierProvider<Tab1PendingRepositoryNotifier, AsyncValue<void>>(
        Tab1PendingRepositoryNotifier.new);
