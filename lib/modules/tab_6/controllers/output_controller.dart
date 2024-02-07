import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/controllers/output_controller.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';

final tab6OutputProvider =
    AsyncNotifierProvider<SchedulingOutputNotifier<Tab2Model>, List<Tab2Model>>(
        () {
  return SchedulingOutputNotifier(tabNumber: 6);
});
