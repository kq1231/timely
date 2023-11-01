import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_one/models/fms_model.dart';
import 'package:timely/modules/tab_one/repositories/tab_one_repo_iml.dart';
import 'package:timely/reusable.dart';

class TabOneRepository extends Notifier<AsyncValue<void>>
    implements TabOneRepositorySkeleton {
  @override
  build() {
    return const AsyncValue.data(null);
  }

  @override
  Future<List<FMSModel>> fetchFMSModels() async {
    final tabOneFile = (await ref.read(dbFilesProvider.future)).tabOneReFile;
    final jsonContent = jsonDecode(await tabOneFile.readAsString());
    final fmsModels = <FMSModel>[];
    for (final date in jsonContent.keys) {
      var content = jsonContent[date];
      Map json = {
        date: [
          [
            content[0][0],
            content[0][1],
            content[0][2],
          ],
          content[1],
          content[2]
        ]
      };
      fmsModels.add(FMSModel.fromJson(json));
    }

    return fmsModels;
  }

  @override
  Future<void> writeFMSModel(FMSModel model) async {
    final tabOneFile = (await ref.read(dbFilesProvider.future)).tabOneReFile;

    final jsonContent = jsonDecode(await tabOneFile.readAsString());
    jsonContent[model.date] = [];
    jsonContent[model.date].add(
      [
        model.fScore,
        model.mScore,
        model.sScore,
      ],
    );
    jsonContent[model.date].add(
      "${model.nextUpdateTime.hour}: ${model.nextUpdateTime.minute}",
    );
    jsonContent[model.date].add(model.text_1);
    await tabOneFile.writeAsString(jsonEncode(jsonContent));
  }

  @override
  Future<void> createDefaultEntry() async {
    final tabOneFile = (await ref.read(dbFilesProvider.future)).tabOneReFile;
    final jsonContent = jsonDecode(await tabOneFile.readAsString());
    String dateToday = DateTime.now().toString().substring(0, 10);
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

  @override
  Future<void> updateNextUpdateTime() async {
    final tabOneFile = (await ref.read(dbFilesProvider.future)).tabOneReFile;
    final jsonContent = jsonDecode(await tabOneFile.readAsString());
    String dateToday = DateTime.now().toString().substring(0, 10);

    FMSModel model = FMSModel.fromJson(jsonContent[dateToday]);
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      DateTime currentTime = DateTime.now();
      DateTime nextUpdateTime = DateFormat("yyyy-MM-dd HH:mm").parse(
          "$dateToday ${model.nextUpdateTime.hour}:${model.nextUpdateTime.minute}");

      if (currentTime.difference(nextUpdateTime).inMinutes == 0) {
        model.nextUpdateTime =
            TimeOfDay(hour: model.nextUpdateTime.hour + 1, minute: 0);
        await writeFMSModel(model);
      }

      if (currentTime.hour == 10) {
        timer.cancel();
      }
    });
  }
}

final tabOneRepositoryProvider =
    NotifierProvider<TabOneRepository, AsyncValue<void>>(TabOneRepository.new);
