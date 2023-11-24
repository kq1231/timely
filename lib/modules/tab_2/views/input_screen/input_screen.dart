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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "Text 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
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
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text("Date"),
                Expanded(child: Container()),
                SizedBox(
                  width: 100,
                  child: OutlinedButton(
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
                ),
                const SizedBox(
                  width: 20,
                ),
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
                const Center(
                  child: Text(
                    "Time",
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: SizedBox(
                    width: 100,
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
                const Center(
                  child: Text(
                    "Duration",
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CupertinoPicker(
                          itemExtent: 30,
                          scrollController: FixedExtentScrollController(
                            initialItem: provider.endTime.inHours,
                          ),
                          onSelectedItemChanged: (val) {
                            controller.setEndTime(
                              Duration(
                                hours: val,
                                minutes: provider.endTime.inMinutes % 60,
                              ),
                            );
                          },
                          children: List<Widget>.generate(
                            25,
                            (index) => Text(
                              (index).toString(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CupertinoPicker(
                          itemExtent: 30,
                          scrollController: FixedExtentScrollController(
                            initialItem: provider.endTime.inMinutes % 60,
                          ),
                          onSelectedItemChanged: (val) {
                            controller.setEndTime(
                              Duration(
                                hours: provider.endTime.inHours,
                                minutes: val,
                              ),
                            );
                          },
                          children: List<Widget>.generate(
                            61,
                            (index) => Text(
                              (index).toString(),
                            ),
                          ),
                        ),
                      )
                    ],
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
                const Text("Repeats"),
                Expanded(child: Container()),
                SizedBox(
                  width: 100,
                  child: FilledButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const RepeatsPage();
                            });
                      },
                      child: Text(
                        provider.frequency ?? "Never",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      )),
                ),
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
