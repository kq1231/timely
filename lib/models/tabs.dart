import 'screens.dart';

class TabOne {
  final Map data;
  String date;
  late Screen screenA;
  late Screen screenB;
  late Screen screenC;
  TabOne(this.data, this.date) {
    screenA = Screen(data, date, ScreenType.a);
    screenB = Screen(data, date, ScreenType.b);
    screenC = Screen(data, date, ScreenType.c);
  }
}
