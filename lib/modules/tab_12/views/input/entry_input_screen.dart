import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/controllers/input/entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/views/input/molecules/sub_entry_input_molecule.dart';
import 'package:timely/modules/tab_12/views/input/scheduling/repeats_page.dart';

class Tab12EntryInputScreen extends ConsumerWidget {
  final bool showSubEntryMolecule;

  const Tab12EntryInputScreen({super.key, required this.showSubEntryMolecule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entry = ref.watch(tab12EntryInputProvider);
    final controller = ref.read(tab12EntryInputProvider.notifier);

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
    switch (entry.tab2Model.frequency) {
      case "Monthly":
        if (entry.tab2Model.basis == Basis.date) {
          repetitionSummary =
              "Repeats on ${entry.tab2Model.repetitions['Dates'].join(', ')} every ${entry.tab2Model.every} months";
        } else {
          repetitionSummary =
              "Repeats on the ${sliderNames[0][entry.tab2Model.repetitions["DoW"][0]].toLowerCase()} ${sliderNames[1][entry.tab2Model.repetitions["DoW"][1]]} every ${entry.tab2Model.every} months";
        }
        break;
      case "Yearly":
        if (entry.tab2Model.basis == Basis.date ||
            entry.tab2Model.basis == null) {
          repetitionSummary =
              "Repeats in ${entry.tab2Model.repetitions["Months"].map((val) => monthNames[val - 1]).toList().join(", ")} every ${entry.tab2Model.every} years";
        } else {
          repetitionSummary =
              "Repeats on the ${sliderNames[0][entry.tab2Model.repetitions["DoW"][0]].toLowerCase()} ${sliderNames[1][entry.tab2Model.repetitions["DoW"][1]]} of ${entry.tab2Model.repetitions["Months"].map((val) => monthNames[val - 1]).toList().join(", ")} every ${entry.tab2Model.every} years";
        }
        break;
      case "Weekly":
        repetitionSummary =
            "Repeats on ${entry.tab2Model.repetitions["Weekdays"].map((val) => sliderNames[1][val]).toList().join(", ")} every ${entry.tab2Model.every} weeks";
      case "Daily":
        repetitionSummary = "Repeats daily";
    }

    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: entry.activity,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Activity Name",
            ),
            onChanged: (activity) {
              controller.setActivity(activity);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: entry.objective,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Objective",
            ),
            onChanged: (objective) {
              controller.setObjective(objective);
            },
          ),
        ),
        const Divider(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Importance"),
              SizedBox(
                height: 100,
                width: 170,
                child: CupertinoPicker(
                  itemExtent: 60,
                  scrollController: FixedExtentScrollController(
                      initialItem: entry.importance - 1),
                  onSelectedItemChanged: (importance) {
                    controller.setImportance(importance + 1);
                  },
                  children:
                      "Not at all Imp,Slightly Imp,Important,Fairly Imp,Very Imp"
                          .split(",")
                          .map((e) => Center(child: Text(e)))
                          .toList(),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 30,
        ),
        // Scheduling
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  "Start",
                ),
              ),
            ),
            const SizedBox(
              width: 20,
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
                      context: context, initialTime: entry.tab2Model.startTime);
                  timeSelected != null
                      ? controller.setStartTime(timeSelected)
                      : null;
                },
                child: Text(
                  entry.tab2Model.startTime.toString().substring(10, 15),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 50));

                if (selectedDate != null) {
                  controller.setStartDate(selectedDate);
                }
              },
              child: Text(
                DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                    .format(entry.tab2Model.startDate!),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  "End",
                ),
              ),
            ),
            const SizedBox(
              width: 20,
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
                      context: context, initialTime: entry.tab2Model.startTime);
                  if (timeSelected != null) {
                    controller.setEndTime(timeSelected);
                  }
                },
                child: Text(
                  entry.tab2Model.startTime.toString().substring(10, 15),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 50));

                if (selectedDate != null) {
                  controller.setEndDate(selectedDate);
                }
              },
              child: Text(
                DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                    .format(entry.tab2Model.endDate!),
              ),
            ),
            const SizedBox(
              width: 20,
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
                  entry.tab2Model.frequency ?? "Never",
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

        showSubEntryMolecule
            ? const Tab12SubEntryInputMolecule(
                showNextOccurenceDate: true,
              )
            : Container(),

        const SizedBox(
          height: 10,
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
                child: const Text(
                  "Cancel",
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Submit"),
              onPressed: () {
                ref.read(tab12EntryInputProvider.notifier).syncToDB(
                      ref.read(tab12SubEntryInputProvider),
                    );
                ref.invalidate(tab12OutputProvider);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Submitted successfully..."),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
