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
