import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/controllers/input_controller.dart';
import 'package:timely/app_theme.dart';

class Tab1InputScreen extends ConsumerWidget {
  const Tab1InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab1InputProvider);
    final controller = ref.read(tab1InputProvider.notifier);
    List labels = Tab1InputLayout.labels;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 170,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ))),
              onPressed: () async {
                var dateSelected = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(provider.date),
                    firstDate: DateTime(0),
                    lastDate: DateTime(
                      DateTime.now().year + 50,
                    ));
                if (dateSelected != null) {
                  controller.setDate(dateSelected);
                }
              },
              child: Text(
                controller.getFormattedDate(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 40,
          ),
          Row(children: [
            const SizedBox(width: 30),
            Text(
              Tab1InputLayout.scoreNames[0],
            ),
            const SizedBox(
              width: 70,
            ),
            ...List.generate(
              1,
              (index) {
                return Expanded(
                  child: SizedBox(
                    height: 180,
                    child: CupertinoPicker(
                      itemExtent: 80,
                      scrollController: FixedExtentScrollController(
                          initialItem: provider.fScore),
                      onSelectedItemChanged: (index) {
                        controller.setFScore(index);
                      },
                      children:
                          labels.map((e) => Center(child: Text(e))).toList(),
                    ),
                  ),
                );
              },
            ),
          ]),
          const Divider(
            height: 40,
          ),
          Row(children: [
            const SizedBox(width: 30),
            Text(
              Tab1InputLayout.scoreNames[1],
            ),
            const SizedBox(
              width: 70,
            ),
            ...List.generate(
              1,
              (index) {
                return Expanded(
                  child: SizedBox(
                    height: 180,
                    child: CupertinoPicker(
                      itemExtent: 80,
                      scrollController: FixedExtentScrollController(
                          initialItem: provider.mScore),
                      onSelectedItemChanged: (index) {
                        controller.setMScore(index);
                      },
                      children:
                          labels.map((e) => Center(child: Text(e))).toList(),
                    ),
                  ),
                );
              },
            ),
          ]),
          const Divider(
            height: 40,
          ),
          Row(children: [
            const SizedBox(width: 30),
            Text(
              Tab1InputLayout.scoreNames[2],
            ),
            const SizedBox(
              width: 70,
            ),
            ...List.generate(
              1,
              (index) {
                return Expanded(
                  child: SizedBox(
                    height: 180,
                    child: CupertinoPicker(
                      itemExtent: 80,
                      scrollController: FixedExtentScrollController(
                          initialItem: provider.sScore),
                      onSelectedItemChanged: (index) {
                        controller.setSScore(index);
                      },
                      children:
                          labels.map((e) => Center(child: Text(e))).toList(),
                    ),
                  ),
                );
              },
            ),
          ]),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Next Update Time",
              ),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? timeSelected = await showTimePicker(
                      context: context, initialTime: provider.nextUpdateTime);
                  if (timeSelected != null) {
                    controller.setNextUpdateTime(timeSelected);
                  }
                },
                child: Column(
                  children: [
                    Text(provider.nextUpdateTime.format(context)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Today's priority",
                    ),
                    initialValue: provider.text_1,
                    onChanged: (text_1) {
                      controller.setText_1(text_1);
                    },
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              ElevatedButton(
                child: const Text("Submit"),
                onPressed: () {
                  controller.syncToDB();
                  ref.invalidate(tab1InputProvider);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Submitted Successfully'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
