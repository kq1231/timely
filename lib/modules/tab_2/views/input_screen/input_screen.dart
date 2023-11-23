import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Text(
                  "Text 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onChanged: (name) => controller.setName(name),
                    ),
                  ),
                ),
              ],
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
                const Text("Date"),
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
                    "Time",
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
                    child: Row(
                  children: [],
                )),
                Expanded(
                  child: Container(),
                ),
                const Center(
                  child: Text(
                    "Duration",
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
                  width: 20,
                ),
                FilledButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const RepeatsPage();
                          });
                    },
                    child: Text(
                      provider.frequency ?? "Never",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
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
