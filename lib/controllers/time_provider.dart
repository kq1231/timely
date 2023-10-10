import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = Provider.autoDispose<String>((ref) {
  var timeNow = DateTime.now();

  return timeNow.toString().substring(10, 16);
});
