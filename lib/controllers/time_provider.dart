import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = Provider.autoDispose<Map>((ref) {
  var timeNow = DateTime.now().toString().substring(11, 16);
  int nextHour = (int.parse(timeNow.substring(0, 2)) + 1) % 24;

  return {
    "time_1": timeNow,
    "time_2":
        "${nextHour.toString().length == 1 ? '0$nextHour' : nextHour} : ${timeNow.substring(3)}",
  };
});
