import 'package:timely/models/interval.dart';

class ColorRater extends Interval {
  final num ratingResult;
  ColorRater(date, time_1, this.ratingResult)
      : super(date: date, time_1: time_1, types: []);
}
