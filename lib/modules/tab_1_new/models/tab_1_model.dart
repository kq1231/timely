class Tab1Model {
  final int totalPoints = 0;
  final int subtractions = 0;
  final int level = 0;

  Tab1Model({
    required int totalPoints,
    required int subtractions,
    required int level,
  });

  factory Tab1Model.fromJson(json) {
    return Tab1Model(
      totalPoints: json["Total Points"] as int,
      subtractions: json["Subtractions"],
      level: json["Level"],
    );
  }

  Map toJson() {
    return {
      "Total Points": totalPoints,
      "Subtractions": subtractions,
      "Level": level,
    };
  }

  Tab1Model copyWith({int? totalPoints, int? subtractions, int? level}) {
    return Tab1Model(
      totalPoints: totalPoints ?? this.totalPoints,
      subtractions: subtractions ?? this.subtractions,
      level: level ?? this.level,
    );
  }
}
