import 'package:flutter/cupertino.dart';
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
        child: Column(
          children: [
            // Row of Radio buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Priority"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        child: VerticalDivider(),
                      ),
                      SizedBox(
                        height: 120,
                        child: CupertinoPicker(
                            itemExtent: 60,
                            scrollController: FixedExtentScrollController(
                                initialItem: provider.priority),
                            onSelectedItemChanged: (index) {
                              controller.setPriority(index);
                            },
                            children: labels
                                .map((label) => Center(child: Text(label)))
                                .toList()),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          var dateSelected = await showDatePicker(
                              context: context,
                              initialDate: provider.date == null
                                  ? DateTime.now()
                                  : DateTime.parse(provider.date!),
                              firstDate: DateTime(2017, 1, 1),
                              lastDate:
                                  DateTime(DateTime.now().year + 2, 1, 1));
                          if (dateSelected != null) {
                            controller.setDate(
                                dateSelected.toString().substring(0, 10));
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
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
                ),
              ],
            ),

            const Divider(
              height: 40,
            ),

            // Activity Comment/text_1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "Priority",
                ),
                initialValue: provider.text_1,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) => controller.setActivity(value),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    Tab3InputLayout.cancelButtonText,
                    style: Tab3InputLayout.cancelButtonStyle,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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
