import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_12/controllers/input/entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/views/input/molecules/sub_entry_input_molecule.dart';

class Tab12EntryInputScreen extends ConsumerWidget {
  final bool showSubEntryMolecule;

  const Tab12EntryInputScreen({super.key, required this.showSubEntryMolecule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab12EntryInputProvider);
    final controller = ref.read(tab12EntryInputProvider.notifier);

    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.activity,
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
            initialValue: provider.objective,
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
                width: 150,
                child: CupertinoPicker(
                  itemExtent: 60,
                  scrollController: FixedExtentScrollController(
                      initialItem: provider.importance - 1),
                  onSelectedItemChanged: (importance) {
                    controller.setImportance(importance + 1);
                  },
                  children: "Insignificant,Low,Medium,High,Critical"
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
        showSubEntryMolecule ? const Tab12SubEntryInputMolecule() : Container(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Start Date"),
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
                  DateFormat(DateFormat.ABBR_MONTH_DAY)
                      .format(provider.startDate),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("End Date"),
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
                  DateFormat(DateFormat.ABBR_MONTH_DAY)
                      .format(provider.endDate),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 30,
        ),
        const SizedBox(
          height: 40,
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
