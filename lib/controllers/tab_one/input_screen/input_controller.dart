import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';
import 'package:timely/controllers/launch_screen/remaining_time_ticker.dart';
import 'package:timely/controllers/tab_one/intervals_provider.dart';
import 'package:timely/controllers/tab_one/output_screens/output_screen_a_provider.dart';
import 'package:timely/controllers/tab_one/output_screens/output_screen_c_provider.dart';
import 'package:timely/controllers/time_provider.dart';
import 'package:timely/models/interval.dart';
import 'package:timely/models/type.dart';

class TabOneInputNotifier extends Notifier<Interval> {
  @override
  Interval build() {
    return Interval(
      date: "",
      time_1: ref.read(timeProvider).toString(),
      time_2: ref.read(timeProvider).toString(),
      types: <Type>[
        Type(typeCategory: TypeCategory.a, rating: [1, 0, 0], comment: ""),
        Type(typeCategory: TypeCategory.b, rating: [1, 0, 0], comment: ""),
        Type(typeCategory: TypeCategory.c, rating: [1, 0, 0], comment: ""),
      ],
    );
  }

  void setTime_2(String time_2) {
    state.time_2 = time_2;
  }

  void setTime_1(String time_1) {
    state.time_1 = time_1;
  }

  void setTypeAComment(String comment) {
    state.types[0].comment = comment;
  }

  void setTypeBComment(String comment) {
    state.types[1].comment = comment;
  }

  void setTypeCComment(String comment) {
    state.types[2].comment = comment;
  }

  void setTypeARating(int val) {
    List rating = [];

    for (int i in Iterable.generate(3)) {
      if (i == val) {
        rating.add(1);
      } else {
        rating.add(0);
      }
    }
    state.types[0].rating = rating;
  }

  void setTypeBRating(int val) {
    List rating = [];

    for (int i in Iterable.generate(3)) {
      if (i == val) {
        rating.add(1);
      } else {
        rating.add(0);
      }
    }

    state.types[1].rating = rating;
  }

  void setTypeCRating(int val) {
    List rating = [];

    for (int i in Iterable.generate(3)) {
      if (i == val) {
        rating.add(1);
      } else {
        rating.add(0);
      }
    }

    state.types[2].rating = rating;
  }

  void refreshProviders() {
    ref.invalidate(outputScreenAProvider);
    ref.invalidate(outputScreenCProvider);
    ref.invalidate(tabOneIntervalsProvider);
    ref.invalidate(remainingTimeTickerProvider);
  }

  Future<void> syncChangesToDB(String date) async {
    File tabOneFile = (await ref.watch(dbFilesProvider.future)).tabOneFile;
    // First, read the file content
    Map tabOneData = jsonDecode(await tabOneFile.readAsString()) as Map;

    // Data creation
    if (!tabOneData.keys.contains(date)) {
      tabOneData[date] = {"text_1": "", "data": {}};
    }

    // Mutations
    tabOneData[date]["text_1"] = ref.read(text_1Provider);
    tabOneData[date]["data"][state.time_1.replaceAll(" ", "")] = {
      "time_2": state.time_2.replaceAll(" ", ""),
      "type_a": {
        "rating": state.types[0].rating,
        "comment": state.types[0].comment,
      },
      "type_b": {
        "rating": state.types[1].rating,
        "comment": state.types[1].comment,
      },
      "type_c": {
        "rating": state.types[2].rating,
        "comment": state.types[2].comment,
      }
    };

    // Push changes to file
    await tabOneFile.writeAsString(
      jsonEncode(tabOneData),
    );
  }
}

// Providers || Controllers

final tabOneInputController =
    NotifierProvider<TabOneInputNotifier, Interval>(() {
  return TabOneInputNotifier();
});

final text_1Provider = StateProvider<String>((ref) {
  return "";
});
