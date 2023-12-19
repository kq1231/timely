import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2_6_7/common/controllers/output_controller.dart';
import 'package:timely/modules/tab_2_6_7/common/models/tab_2_model.dart';

final tab2OutputProvider = AsyncNotifierProvider<Tab2OutputNotifier, List>(() {
  return Tab2OutputNotifier(tabNumber: 2, modelizeMethod: Tab2Model.fromJson);
});
