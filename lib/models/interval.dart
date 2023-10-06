import 'package:timely/models/type.dart';

class Interval {
  String date;
  String time_1;
  List<Type> types;

  Interval({
    required this.date,
    required this.time_1,
    required this.types,
  });
}
