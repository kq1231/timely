import 'subtype.dart';

class Type {
  Map data;
  String type;
  String date;
  late String text_1;
  late SubType type_1;
  late SubType type_2;
  late SubType type_3;

  Type(this.data, this.date, this.type) {
    Map key = data[date]["screen_$type"];
    text_1 = key["text_1"];

    type_1 = SubType(
        text_1: key["type_1"]["text_1"],
        text_2: key["type_1"]["text_2"],
        time_1: key["type_1"]["time_1"],
        time_2: key["type_1"]["time_2"],
        rating: key["type_1"]["rating"]);
    type_2 = SubType(
        text_1: key["type_2"]["text_1"],
        text_2: key["type_2"]["text_2"],
        time_1: key["type_2"]["time_1"],
        time_2: key["type_2"]["time_2"],
        rating: key["type_2"]["rating"]);
    type_3 = SubType(
        text_1: key["type_3"]["text_1"],
        text_2: key["type_3"]["text_2"],
        time_1: key["type_3"]["time_1"],
        time_2: key["type_3"]["time_2"],
        rating: key["type_3"]["rating"]);
  }
}

class Types {
  static String a = "a";
  static String b = "b";
  static String c = "c";
}
