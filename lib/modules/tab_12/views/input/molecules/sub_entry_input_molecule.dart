import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_12/views/input/scheduling/repeats_page.dart';

class Tab12SubEntryInputMolecule extends ConsumerWidget {
  const Tab12SubEntryInputMolecule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab12SubEntryInputProvider);
    final controller = ref.read(tab12SubEntryInputProvider.notifier);

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

    return Column(
      children: [
        // Next Task TextField
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Next Task",
            ),
            onChanged: (name) {
              controller.setName(name);
            },
          ),
        ),
        const Divider(
          height: 40,
        ),

        // Scheduling
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
      ],
    );
  }
}
