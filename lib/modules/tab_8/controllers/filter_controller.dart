import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider = StateProvider<Map>((ref) {
  return {
    "LSJ": <int>{0},
    "HML": <int>{0},
  };
});
