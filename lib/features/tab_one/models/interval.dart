import 'package:timely/features/tab_one/models/type.dart';

class Interval {
  String date;
  String time_1;
  String time_2;
  List<Type> types;

  Interval({
    required this.date,
    required this.time_1,
    required this.time_2,
    required this.types,
  });
}
