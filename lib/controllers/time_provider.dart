import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = Provider.autoDispose<TimeOfDay>((ref) {
  var timeNow = TimeOfDay.now();

  return timeNow;
});
