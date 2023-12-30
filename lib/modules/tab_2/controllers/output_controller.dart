import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/scheduling/controllers/output_controller.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';

final tab2OutputProvider =
    AsyncNotifierProvider<Tab2OutputNotifier<Tab2Model>, List<Tab2Model>>(() {
  return Tab2OutputNotifier(tabNumber: 2);
});
