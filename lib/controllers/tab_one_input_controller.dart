import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/models/subtype.dart';

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

  void setTypeARating(List<int> rating) {
    state[0].rating = rating;
  }

  void setTypeBRating(List<int> rating) {
    state[1].rating = rating;
  }

  void setTypeCRating(List<int> rating) {
    state[2].rating = rating;
  }

  void setText_1(String text_1) {
    for (int i in Iterable.generate(3)) {
      state[i].text_1 = text_1;
    }
  }

  void activateTypeARatingValue() {
    state[0].ratingValue = 0;
  }

  void activateTypeBRatingValue() {
    state[0].ratingValue = 1;
  }

  void activateTypeCRatingValue() {
    state[0].ratingValue = 2;
  }
}

final tabOneInputProvider =
    NotifierProvider<TabOneInputNotifier, List<InputSubType>>(() {
  return TabOneInputNotifier();
});
