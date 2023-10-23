class Type {
  late String typeCategory;
  late List rating;
  late String comment;

  Type(
      {required this.typeCategory,
      required this.rating,
      required this.comment});
}

class TypeCategory {
  static String a = "a";
  static String b = "b";
  static String c = "c";
}
