import 'package:flutter/material.dart';

class FMSModel {
  late DateTime date;
  late Duration fScore;
  late Duration mScore;
  late Duration sScore;
  late int fStatus;
  late int mStatus;
  late int sStatus;
  late String text_1;
  late TimeOfDay nextUpdateTime;

  FMSModel({
    required this.date,
    required this.fScore,
    required this.mScore,
    required this.sScore,
    required this.fStatus,
    required this.mStatus,
    required this.sStatus,
    required this.text_1,
    required this.nextUpdateTime,
  });

  FMSModel.fromJson(Map json) {
    var date = DateTime.parse(json.keys.first);

    var content = json.values.toList().first;
    List<Duration> scores =
        List.generate(3, (index) => Duration(seconds: content.first[index]));
    List<int> statuses = List.generate(3, (index) => content.last[index]);
    String time = content[1];
    String text_1 = content[2];
    List timeParts = time.split(":");
    TimeOfDay nextUpdateTime = TimeOfDay(
        hour: int.parse(timeParts.first), minute: int.parse(timeParts.last));

    this.date = date;

    fScore = scores[0];
    mScore = scores[1];
    sScore = scores[2];

    fStatus = statuses[0];
    mStatus = statuses[1];
    sStatus = statuses[2];

    this.text_1 = text_1;

    this.nextUpdateTime = nextUpdateTime;
  }

  Map toJson() {
    return {
      date.toString().substring(0, 10): [
        [
          fScore.inSeconds,
          mScore.inSeconds,
          sScore.inSeconds,
        ],
        "${nextUpdateTime.hour}: ${nextUpdateTime.minute}",
        text_1,
        [
          fStatus,
          mStatus,
          sStatus,
        ],
      ]
    };
  }

  FMSModel copyWith({
    date,
    fScore,
    mScore,
    sScore,
    fStatus,
    mStatus,
    sStatus,
    nextUpdateTime,
    text_1,
  }) {
    return FMSModel(
      date: date ?? this.date,
      fScore: fScore ?? this.fScore,
      mScore: mScore ?? this.mScore,
      sScore: sScore ?? this.sScore,
      fStatus: fStatus ?? this.fStatus,
      mStatus: mStatus ?? this.mStatus,
      sStatus: sStatus ?? this.sStatus,
      nextUpdateTime: nextUpdateTime ?? this.nextUpdateTime,
      text_1: text_1 ?? this.text_1,
    );
  }
}
