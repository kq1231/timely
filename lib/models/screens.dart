import 'type.dart';

class Screen {
  Map data;
  String screenType;
  String date;
  late String text_1;
  late Type type_1;
  late Type type_2;
  late Type type_3;

  Screen(this.data, this.date, this.screenType) {
    Map key = data[date]["screen_$screenType"];
    text_1 = key["text_1"];

    type_1 = Type(
        text_2: key["type_1"]["text_2"],
        time_1: key["type_1"]["time_1"],
        time_2: key["type_1"]["time_2"],
        rating: key["type_1"]["rating"]);
    type_2 = Type(
        text_2: key["type_2"]["text_2"],
        time_1: key["type_2"]["time_1"],
        time_2: key["type_2"]["time_2"],
        rating: key["type_2"]["rating"]);
    type_3 = Type(
        text_2: key["type_3"]["text_2"],
        time_1: key["type_3"]["time_1"],
        time_2: key["type_3"]["time_2"],
        rating: key["type_3"]["rating"]);
  }
}

class ScreenType {
  static String a = "a";
  static String b = "b";
  static String c = "c";
}
