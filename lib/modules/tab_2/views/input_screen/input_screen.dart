import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/tab_2/controllers/input_controller.dart';
import 'repeats_page.dart';

class Tab2InputScreen extends ConsumerStatefulWidget {
  const Tab2InputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => Tab2InputScreenState();
}

class Tab2InputScreenState extends ConsumerState<Tab2InputScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab2InputProvider);
    final controller = ref.read(tab2InputProvider.notifier);

    return ListView(
      children: [
        SizedBox(
          height: 60,
          child: Center(
            child: FilledButton(
              child: Text(
                Tab2InputLayout.text1ButtonText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Text 1"),
                      content: TextField(
                        onChanged: (val) {
                          controller.setName(val);
                        },
                      ),
                      actions: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.done))
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
        const Divider(),
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Start Date"),
                OutlinedButton(
                    onPressed: () async {
                      DateTime? dateSelected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(0),
                          lastDate: DateTime(DateTime.now().year + 50));
                      if (dateSelected != null) {
                        controller.setStartDate(dateSelected);
                      }
                    },
                    child: Text(DateFormat(DateFormat.ABBR_MONTH_DAY)
                        .format(provider.startDate))),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
        const Divider(),
        Column(
          children: [
            // Repeat button
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? timeSelected = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      timeSelected != null
                          ? controller.setStartTime(timeSelected)
                          : null;
                    },
                    child: Text(provider.startTime.format(context)),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                const Center(
                  child: Text(
                    "Start Time",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // End repeat button
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? timeSelected = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      timeSelected != null
                          ? controller.setEndTime(timeSelected)
                          : null;
                    },
                    child: Text(provider.endTime.format(context)),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                const Center(
                  child: Text(
                    "End Time",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 13,
                ),
                ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return RepeatsPage();
                          });
                    },
                    child: Text(provider.frequency)),
                Expanded(child: Container()),
                const Text("Repeats"),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    controller.syncToDB();
                  },
                )
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ],
    );
  }
}
