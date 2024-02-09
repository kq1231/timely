import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/controllers/output_controller.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';

final tab7OutputProvider = AutoDisposeAsyncNotifierProvider<
    SchedulingOutputNotifier<Tab2Model>, Map<String, List<Tab2Model>>>(() {
  return SchedulingOutputNotifier(7);
});
