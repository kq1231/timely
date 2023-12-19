import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2_6_7/common/controllers/output_controller.dart';

final tab2OutputProvider = AsyncNotifierProvider<Tab2OutputNotifier, List>(() {
  return Tab2OutputNotifier(tabNumber: 2);
});
