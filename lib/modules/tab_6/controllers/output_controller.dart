import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/output_controller.dart';
import 'package:timely/common/scheduling/scheduling_model.dart';

final tab6OutputProvider = AutoDisposeAsyncNotifierProvider<
    SchedulingOutputNotifier<SchedulingModel>,
    Map<String, List<SchedulingModel>>>(() {
  return SchedulingOutputNotifier(6);
});
