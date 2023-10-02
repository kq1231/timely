import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/models/subtype.dart';
import 'db_files_provider.dart';

class InputSubType extends SubType {
  int ratingValue = 0;

  InputSubType({
    required String text_1,
    required String time_1,
    required String time_2,
    required String text_2,
    required List rating,
    required int ratingValue,
  }) : super(
            rating: rating,
            text_1: text_1,
            text_2: text_2,
            time_1: time_1,
            time_2: time_2);
}

class TabOneInputNotifier extends Notifier<List<InputSubType>> {
  @override
  List<InputSubType> build() {
    return [
      for (int _ in Iterable.generate(3))
        InputSubType(
            text_1: "",
            text_2: "",
            time_1: "",
            time_2: "",
            rating: [],
            ratingValue: 0),
    ];
  }

  void setTime_1(String time_1) {
    for (int i in Iterable.generate(3)) {
      state[i].time_1 = time_1;
    }
  }

  void setTime_2(String time_2) {
    for (int i in Iterable.generate(state.length)) {
      state[i].time_2 = time_2;
    }
  }

  void setTypeAText_2(String text_2) {
    state[0].text_2 = text_2;
  }

  void setTypeBText_2(String text_2) {
    state[1].text_2 = text_2;
  }

  void setTypeCText_2(String text_2) {
    state[2].text_2 = text_2;
  }

  void setTypeARating() {
    List rating = [];
    for (int i in Iterable.generate(3)) {
      if (state[0].ratingValue == i) {
        rating.add(1);
      } else {
        rating.add(0);
      }
    }
    state[0].rating = rating;
  }

  void setTypeBRating() {
    List rating = [];
    for (int i in Iterable.generate(3)) {
      if (state[1].ratingValue == i) {
        rating.add(1);
      } else {
        rating.add(0);
      }
    }
    state[1].rating = rating;
  }

  void setTypeCRating() {
    List rating = [];
    for (int i in Iterable.generate(3)) {
      if (state[2].ratingValue == i) {
        rating.add(1);
      } else {
        rating.add(0);
      }
    }
    state[2].rating = rating;
  }

  void setText_1(String text_1) {
    for (int i in Iterable.generate(3)) {
      state[i].text_1 = text_1;
    }
  }

  void activateTypeARatingValue(int value) {
    state[0].ratingValue = value;
  }

  void activateTypeBRatingValue(int value) {
    state[1].ratingValue = value;
  }

  void activateTypeCRatingValue(int value) {
    state[2].ratingValue = value;
  }

  Future<void> syncToDB(String date) async {
    File tabOneFile = ref.read(dbFilesProvider)["tabOne"]!;
    Map tabOneData = jsonDecode(await tabOneFile.readAsString()) as Map;

    setTypeARating();
    setTypeBRating();
    setTypeCRating();

    // First add all the text_1[s]
    int i = 0;
    for (String type in ["type_a", "type_b", "type_c"]) {
      tabOneData[date][type]["text_1"] = state[i].text_1;

      // Then, add all the children
      tabOneData[date][type]["children"].add({
        "text_2": state[i].text_2,
        "time_1": state[i].time_1,
        "time_2": state[i].time_2,
        "rating": state[i].rating,
      });

      i++;
    }

    // Sync the changes to the file
    await tabOneFile.writeAsString(jsonEncode(tabOneData));
  }
}

final tabOneInputProvider =
    NotifierProvider<TabOneInputNotifier, List<InputSubType>>(() {
  return TabOneInputNotifier();
});
