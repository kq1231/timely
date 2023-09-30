import 'type.dart';

class TabOne {
  final Map data;
  String date;
  late Type typeA;
  late Type typeB;
  late Type typeC;
  TabOne(this.data, this.date) {
    typeA = Type(data, date, Types.a);
    typeB = Type(data, date, Types.b);
    typeC = Type(data, date, Types.c);
  }
}
