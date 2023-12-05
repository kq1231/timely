import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';

class Tab3InputScreen extends ConsumerWidget {
  const Tab3InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab3InputProvider);
    final controller = ref.watch(tab3InputProvider.notifier);

    List labels = Tab3InputLayout.labels;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // Row of Radio buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...List.generate(3, (index) {
                  return Column(
                    children: [
                      Radio(
                          value: provider.priority,
                          groupValue: index,
                          onChanged: (val) {
                            controller.setPriority(index);
                          }),
                      const SizedBox(height: 10),
                      Text(
                        labels[index],
                        style: Tab3InputLayout.labelsStyle,
                      ),
                    ],
                  );
                })
              ],
            ),

            // Space
            const SizedBox(
              height: 30,
            ),

            // Row for selecting date and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var dateSelected = await showDatePicker(
                        context: context,
                        initialDate: provider.date == null
                            ? DateTime.now()
                            : DateTime.parse(provider.date!),
                        firstDate: DateTime(2017, 1, 1),
                        lastDate: DateTime(DateTime.now().year + 2, 1, 1));
                    if (dateSelected != null) {
                      controller
                          .setDate(dateSelected.toString().substring(0, 10));
                    }
                  },
                  child: provider.date != null
                      ? Text(DateFormat("dd-MMM")
                          .format(DateTime.parse(provider.date!)))
                      : Text(
                          Tab3InputLayout.dateButtonText,
                          style: Tab3InputLayout.dateButtonStyle,
                        ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var timeSelected = await showTimePicker(
                        context: context,
                        initialTime: provider.time ?? TimeOfDay.now());
                    if (timeSelected != null) {
                      controller.setTime(timeSelected);
                    }
                  },
                  child: provider.time != null
                      ? Text(provider.time!.format(context))
                      : Text(
                          Tab3InputLayout.timeButtonText,
                          style: Tab3InputLayout.timeButtonStyle,
                        ),
                )
              ],
            ),

            // Space
            const SizedBox(
              height: 30,
            ),

            // Activity Comment/text_1
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  initialValue: provider.text_1,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) => controller.setActivity(value),
                ),
              ),
            ),

            // Space
            const SizedBox(
              height: 30,
            ),

            // Submit Button and Cancel Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text(
                    Tab3InputLayout.cancelButtonText,
                    style: Tab3InputLayout.cancelButtonStyle,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text(
                    Tab3InputLayout.submitButtonText,
                    style: Tab3InputLayout.submitButtonStyle,
                  ),
                  onPressed: () {
                    controller.syncToDB();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          Tab3InputLayout.submissionStatusMessage,
                          style: Tab3InputLayout.submissionStatusMessageStyle,
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
