import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1_new/models/tab_1_model.dart';
import 'package:timely/reusables.dart';

int incrementPointsBy = 2;

class Tab1RepositoryNotifier extends Notifier<void> {
  @override
  build() {}

  Future<void> incrementPointsByTimeCheck() async {
    File file = (await ref.read(dbFilesProvider.future))[1]![0];
    Map json = jsonDecode(await file.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);
    Tab1Model model = Tab1Model.fromJson(json[dateToday]);

    // If total score - subtractions - 3 is negative then add three points
    // Else if (total score - subtractions - 3) / 2 != (time.current - 6)
    // Then add 2

    if (model.totalPoints - model.subtractions - 3 < 0) {
      model = model.copyWith(totalPoints: model.totalPoints + 3);
    } else if ((model.totalPoints - model.subtractions - 3) / 2 !=
        (DateTime.now().copyWith(hour: DateTime.now().hour - 6)).hour) {
      model =
          model.copyWith(totalPoints: model.totalPoints + incrementPointsBy);
    }
  }

  Future<void> writeTab1Model(Tab1Model model, {bool? force}) async {
    File file = (await ref.read(dbFilesProvider.future))[1]![0];
    Map json = jsonDecode(await file.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    if (force == true || !json.containsKey(dateToday)) {
      json[dateToday] = {};
      json[dateToday] = model.toJson();

      await file.writeAsString(jsonEncode(json));
    }
  }

  Future<Tab1Model> fetchModel() async {
    File file = (await ref.read(dbFilesProvider.future))[1]![0];
    Map json = jsonDecode(await file.readAsString());

    String dateToday = DateTime.now().toString().substring(0, 10);

    return Tab1Model.fromJson(json[dateToday]);
  }
}

final tab1RepositoryProviderNew =
    NotifierProvider<Tab1RepositoryNotifier, void>(Tab1RepositoryNotifier.new);
