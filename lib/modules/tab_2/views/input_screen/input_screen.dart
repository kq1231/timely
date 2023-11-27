import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  "Activity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onChanged: (name) => controller.setName(name),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const Divider(),
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            // Repeat button
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Center(
                  child: Text(
                    "Time",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        TimeOfDay? timeSelected = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        timeSelected != null
                            ? controller.setStartTime(timeSelected)
                            : null;
                      },
                      child: Text(
                        provider.startTime.toString().substring(10, 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          magnification: 1.2,
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
                            (index) => Center(
                              child: Text(
                                (index).toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CupertinoPicker(
                          itemExtent: 40,
                          magnification: 1.2,
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
                            (index) => Center(
                              child: Text(
                                (index).toString(),
                              ),
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
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Repeats",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: 200,
                  height: 60,
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
            const SizedBox(
              height: 50,
            ),
            const Divider(),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 160,
                  height: 60,
                  child: ElevatedButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 160,
                  height: 60,
                  child: ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      controller.syncToDB();
                      Navigator.pop(context);
                    },
                  ),
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
