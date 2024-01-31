import 'package:flutter/material.dart';

class FMSModel {
  late DateTime date;
  late Duration fScore;
  late Duration mScore;
  late Duration sScore;
  late int fStatus;
  late int mStatus;
  late int sStatus;
  late DateTime? fPauseTime;
  late DateTime? mPauseTime;
  late DateTime? sPauseTime;
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
    this.fPauseTime,
    this.mPauseTime,
    this.sPauseTime,
    required this.text_1,
    required this.nextUpdateTime,
  });

  FMSModel.fromJson(Map json) {
    var date = DateTime.parse(json.keys.first);

    var content = json.values.toList().first;
    List<Duration> scores =
        List.generate(3, (index) => Duration(seconds: content.first[index]));
    List<int> statuses = List.generate(3, (index) => content[3][index]);
    String time = content[1];
    String text_1 = content[2];
    List timeParts = time.split(":");
    TimeOfDay nextUpdateTime = TimeOfDay(
        hour: int.parse(timeParts.first), minute: int.parse(timeParts.last));
    List pauseTimes = content[4];

    this.date = date;

    fScore = scores[0];
    mScore = scores[1];
    sScore = scores[2];

    fStatus = statuses[0];
    mStatus = statuses[1];
    sStatus = statuses[2];

    fPauseTime = pauseTimes[0] != null ? DateTime.parse(pauseTimes[0]) : null;
    mPauseTime = pauseTimes[1] != null ? DateTime.parse(pauseTimes[1]) : null;
    sPauseTime = pauseTimes[2] != null ? DateTime.parse(pauseTimes[2]) : null;

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
        [
          fPauseTime != null ? fPauseTime!.toIso8601String() : null,
          mPauseTime != null ? mPauseTime!.toIso8601String() : null,
          sPauseTime != null ? sPauseTime!.toIso8601String() : null,
        ] // -> Pause Times
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
    fPauseTime,
    mPauseTime,
    sPauseTime,
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
      fPauseTime: fPauseTime ?? this.fPauseTime,
      mPauseTime: mPauseTime ?? this.mPauseTime,
      sPauseTime: sPauseTime ?? this.sPauseTime,
    );
  }
}
