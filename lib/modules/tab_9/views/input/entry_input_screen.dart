import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/controllers/input/entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_9/views/input/molecules/sub_entry_input_molecule.dart';

class Tab9EntryInputScreen extends ConsumerWidget {
  final bool showSubEntryMolecule;

  const Tab9EntryInputScreen({super.key, required this.showSubEntryMolecule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(tab9EntryInputProvider);
    final controller = ref.read(tab9EntryInputProvider.notifier);

    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.condition,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Condition",
            ),
            onChanged: (condition) {
              controller.setCondition(condition);
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
              const Text("Criticality"),
              SizedBox(
                height: 100,
                width: 150,
                child: CupertinoPicker(
                  itemExtent: 60,
                  scrollController: FixedExtentScrollController(
                      initialItem: provider.criticality - 1),
                  onSelectedItemChanged: (criticality) {
                    controller.setCriticality(criticality + 1);
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
        const SizedBox(
          height: 30,
        ),
        showSubEntryMolecule ? const Tab9SubEntryInputMolecule() : Container(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.care,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Care",
            ),
            onChanged: (care) {
              controller.setCare(care);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.lessonLearnt,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Lesson Learnt",
            ),
            onChanged: (lessonLearnt) {
              controller.setLessonLearnt(lessonLearnt);
            },
          ),
        ),
        SizedBox(
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
                ref.read(tab9EntryInputProvider.notifier).syncToDB(
                      ref.read(tab9SubEntryInputProvider),
                    );
                ref.invalidate(tab9OutputProvider);
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
