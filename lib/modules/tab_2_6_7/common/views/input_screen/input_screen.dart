import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2_6_7/common/controllers/input_controller.dart';
import 'package:timely/modules/tab_2_6_7/common/models/tab_2_model.dart';
import 'repeats_page.dart';

class Tab2InputScreen extends ConsumerStatefulWidget {
  final bool? showDuration;
  final int tabNumber;
  const Tab2InputScreen({
    super.key,
    this.showDuration,
    required this.tabNumber,
  });

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
    }

    return ListView(
      children: [
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              initialValue: provider.name,
              autofocus: false,
              decoration: const InputDecoration(
                hintText: "Activity",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
              onChanged: (name) => controller.setName(name),
            ),
          ),
        ),
        const Divider(height: 30),
        Column(
          children: [
            // Repeat button
            Row(
              children: [
                const SizedBox(
                  width: 40,
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      TimeOfDay? timeSelected = await showTimePicker(
                          context: context, initialTime: provider.startTime);
                      timeSelected != null
                          ? controller.setStartTime(timeSelected)
                          : null;
                    },
                    child: Text(
                      provider.startTime.toString().substring(10, 15),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            const Divider(height: 30),
            // End repeat
            const SizedBox(
              height: 10,
            ),
            widget.showDuration == false
                ? Container()
                : Column(
                    children: [
                      const Center(
                        child: Text(
                          "Duration",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 120,
                              child: CupertinoPicker(
                                itemExtent: 50,
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
                              height: 120,
                              child: CupertinoPicker(
                                itemExtent: 50,
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
                      const Divider(
                        height: 30,
                      ),
                    ],
                  ),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                const Text(
                  "Repeats",
                  style: TextStyle(),
                ),
                Expanded(child: Container()),
                FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
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
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white),
                    )),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  repetitionSummary,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const Divider(
              height: 30,
            ),

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
                  child: const Text("Cancel"),
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
                  child: const Text("Submit"),
                  onPressed: () {
                    if (provider.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Do not leave activity text blank!")));
                    } else {
                      if (provider.uuid == null) {
                        controller.syncToDB(widget.tabNumber);
                      } else {
                        controller.syncEditedModel(widget.tabNumber);
                      }
                      Navigator.pop(context);
                    }
                  },
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
