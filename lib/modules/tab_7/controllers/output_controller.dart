import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/output_controller.dart';
import 'package:timely/common/scheduling/tab_2_model.dart';

final tab7OutputProvider = AutoDisposeAsyncNotifierProvider<
    SchedulingOutputNotifier<Tab2Model>, Map<String, List<Tab2Model>>>(() {
  return SchedulingOutputNotifier(7);
});
