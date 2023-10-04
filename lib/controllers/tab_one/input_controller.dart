import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/db_files_provider.dart';
import 'package:timely/models/interval.dart';
import 'package:timely/models/type.dart';

class TabOneInputNotifier extends Notifier<Interval> {
  @override
  Interval build() {
    return Interval(
      time_1: "",
      types: <Type>[
        Type(typeCategory: TypeCategory.a, rating: [1, 0, 0], comment: ""),
        Type(typeCategory: TypeCategory.b, rating: [1, 0, 0], comment: ""),
        Type(typeCategory: TypeCategory.c, rating: [1, 0, 0], comment: ""),
      ],
    );
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

  Future<void> syncChangesToDB() async {
    Map tabOneData =
        jsonDecode(await ref.read(dbFilesProvider).tabOneFile.readAsString());

    // Mutations
    tabOneData["02-10-2023"]["text_1"] = ref.read(text_1Provider);
    tabOneData["02-10-2023"][state.time_1] = {
      "type_a": {
        "rating": [state.types[0].rating],
        "comment": state.types[0].comment,
      },
      "type_b": {
        "rating": [state.types[1].rating],
        "comment": state.types[1].comment,
      },
      "type_c": {
        "rating": [state.types[2].rating],
        "comment": state.types[2].comment,
      }
    };

    // Push changes to file
    File tabOneFile = ref.read(dbFilesProvider).tabOneFile;
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
