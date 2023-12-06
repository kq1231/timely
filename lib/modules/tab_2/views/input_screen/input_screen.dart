import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/controllers/input_controller.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
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

    List sliderNames = [
      ["First", "Second", "Third", "Fourth", "Fifth", "Last"],
      [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ]
    ];

    List monthNames =
        "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec".split(",");

    String repetitionSummary = "";
    switch (provider.frequency) {
      case "Monthly":
        if (provider.basis == Basis.date) {
          repetitionSummary =
              "Repeats on ${provider.repetitions['Dates'].join(', ')} every ${provider.every} months";
        } else {
          repetitionSummary =
              "Repeats on the ${sliderNames[0][provider.repetitions["DoW"][0]].toLowerCase()} ${sliderNames[1][provider.repetitions["DoW"][1]]} every ${provider.every} months";
        }
        break;
      case "Yearly":
        if (provider.basis == Basis.date || provider.basis == null) {
          repetitionSummary =
              "Repeats in ${provider.repetitions["Months"].map((val) => monthNames[val - 1]).toList().join(", ")} every ${provider.every} years";
        } else {
          repetitionSummary =
              "Repeats on the ${sliderNames[0][provider.repetitions["DoW"][0]].toLowerCase()} ${sliderNames[1][provider.repetitions["DoW"][1]]} of ${provider.repetitions["Months"].map((val) => monthNames[val - 1]).toList().join(", ")} every ${provider.every} years";
        }
        break;
      case "Weekly":
        repetitionSummary =
            "Repeats on ${provider.repetitions["Weekdays"].map((val) => sliderNames[1][val]).toList().join(", ")} every ${provider.every} weeks";
      case "Daily":
        repetitionSummary = "Repeats daily";
      default:
        repetitionSummary = "Never repeats";
    }

    return ListView(
      children: [
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              initialValue: provider.name,
              decoration: const InputDecoration(
                hintText: "Activity",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onChanged: (name) => controller.setName(name),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
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
                            context: context, initialTime: provider.startTime);
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
            const Divider(),
            // End repeat
            const SizedBox(
              height: 10,
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
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: CupertinoPicker(
                      itemExtent: 70,
                      magnification: 1.2,
                      scrollController: FixedExtentScrollController(
                        initialItem: provider.dur.inHours,
                      ),
                      onSelectedItemChanged: (val) {
                        controller.setEndTime(
                          Duration(
                            hours: val,
                            minutes: provider.dur.inMinutes % 60,
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
                ),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: CupertinoPicker(
                      itemExtent: 70,
                      magnification: 1.2,
                      scrollController: FixedExtentScrollController(
                        initialItem: provider.dur.inMinutes % 60,
                      ),
                      onSelectedItemChanged: (val) {
                        controller.setEndTime(
                          Duration(
                            hours: provider.dur.inHours,
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
                  ),
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(repetitionSummary),
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
                      if (provider.name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Do not leave activity text blank!")));
                      } else {
                        if (provider.uuid == null) {
                          controller.syncToDB();
                        } else {
                          controller.syncEditedModel();
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
