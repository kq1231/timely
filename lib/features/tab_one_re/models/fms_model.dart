import 'package:flutter/material.dart';

class FMSModel {
  late String date;
  late int fScore;
  late int mScore;
  late int sScore;
  late String text_1;
  late TimeOfDay nextUpdateTime;

  FMSModel(
      {required this.date,
      required this.fScore,
      required this.mScore,
      required this.sScore,
      required this.text_1,
      required this.nextUpdateTime});

  FMSModel.fromJson(Map json) {
    var date = json.keys.toList().first;

    var content = json.values.toList().first;
    print(content);
    List<int> scores = List.generate(3, (index) => content.first[index]);
    String time = content[1];
    String text_1 = content.last;
    List timeParts = time.split(":");
    TimeOfDay nextUpdateTime = TimeOfDay(
        hour: int.parse(timeParts.first), minute: int.parse(timeParts.last));

    this.date = date;
    fScore = scores[0];
    mScore = scores[1];
    sScore = scores[2];
    this.text_1 = text_1;
    this.nextUpdateTime = nextUpdateTime;
  }

  Map toJson() {
    return {
      date: [
        [fScore, mScore, sScore],
        nextUpdateTime,
        text_1,
      ]
    };
  }

  FMSModel copyWith({date, fScore, mScore, sScore, nextUpdateTime, text_1}) {
    return FMSModel(
      date: date ?? this.date,
      fScore: fScore ?? this.fScore,
      mScore: mScore ?? this.mScore,
      sScore: sScore ?? this.sScore,
      nextUpdateTime: nextUpdateTime ?? this.nextUpdateTime,
      text_1: text_1 ?? this.text_1,
    );
  }
}
