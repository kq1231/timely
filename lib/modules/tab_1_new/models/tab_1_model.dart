class Tab1Model {
  late final int totalPoints;
  late final int subtractions;
  late final int level;

  Tab1Model({
    required int totalPoints,
    required int subtractions,
    required int level,
  });

  factory Tab1Model.fromJson(json) {
    return Tab1Model(
      totalPoints: json["Total Points"],
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
