import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/atomic/templates/input/tab_3_input_template.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';
import 'package:timely/modules/tab_3/tokens/tab_3_constants.dart';

class Tab3InputPage extends ConsumerWidget {
  final bool? removeDateTime;
  const Tab3InputPage({
    super.key,
    this.removeDateTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(tab3InputProvider);
    final controller = ref.watch(tab3InputProvider.notifier);

    return Tab3InputTemplate(
      model: model,
      removeDateTime: removeDateTime,
      onActivityChanged: (activity) => controller.setActivity(activity),
      onDateChanged: (date) => controller.setDate(date),
      onTimeChanged: (time) => controller.setTime(time),
      onPriorityChanged: (index) => controller.setPriority(index),
      onCancelPressed: () => Navigator.pop(context),
      onSubmitPressed: () {
        controller.syncToDB();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Tab3Constants.submissionStatusMessage,
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
