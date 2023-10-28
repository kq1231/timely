class SPWModel {
  late String date;
  late int sScore;
  late int pScore;
  late int wScore;
  late double weight;

  SPWModel(this.date, this.sScore, this.pScore, this.wScore, this.weight);

  SPWModel.fromJson(Map json) {
    date = json.keys.toList()[0];
    List spw = json.values.toList()[0];
    double weight = json.values.toList()[1];
    int accum = 0;
    for (var _ in [sScore, pScore, wScore]) {
      _ = spw[accum];
      accum += 1;
    }
    this.weight = weight;
  }

  Map toJson(date, sScore, pScore, wScore, weight) {
    return {
      date: [
        [sScore, pScore, wScore],
        weight
      ]
    };
  }

  SPWModel copyWith({date, sScore, pScore, wScore, weight}) {
    return SPWModel(
      date ?? this.date,
      sScore ?? this.sScore,
      pScore ?? this.pScore,
      wScore ?? this.wScore,
      weight ?? this.weight,
    );
  }
}
// TODO inshaa Allah :: Implement this class

