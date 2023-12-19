import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/controllers/output_controller.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';

final tab10OutputProvider = AsyncNotifierProvider<OutputNotifier, List>(() {
  return OutputNotifier(tabNumber: 10, modelizeMethod: Tab10Model.fromJson);
});
