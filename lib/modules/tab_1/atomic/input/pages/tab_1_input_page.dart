import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/atomic/input/templates/tab_1_input_template.dart';
import 'package:timely/modules/tab_1/controllers/input_controller.dart';

class Tab1InputPage extends ConsumerWidget {
  const Tab1InputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerOfFMSModel = ref.watch(tab1InputProvider);
    final controller = ref.read(tab1InputProvider.notifier);

    return Tab1InputTemplate(
        initialText: providerOfFMSModel.text_1,
        initialDate: providerOfFMSModel.date,
        initialTime: providerOfFMSModel.nextUpdateTime,
        onTextChanged: (text_1) => controller.setText_1(text_1),
        onDateChanged: (date) => controller.setDate(date),
        onTimeChanged: (time) => controller.setNextUpdateTime(time),
        onSubmitPressed: () {
          // Write the model
          controller.syncToDB();

          // Refresh the output provider
          ref.invalidate(tab1InputProvider);

          // Go back
          Navigator.of(context).pop();

          // Display a message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Submitted Successfully'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        onPickerSelectionChangedList: [
          (index) => controller.setFScore(index),
          (index) => controller.setMScore(index),
          (index) => controller.setSScore(index)
        ],
        initialPickerItemsIndices: [
          providerOfFMSModel.fScore,
          providerOfFMSModel.mScore,
          providerOfFMSModel.sScore,
        ]);
  }
}
