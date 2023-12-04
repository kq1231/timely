import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/controllers/input_controller.dart';
import 'package:timely/app_theme.dart';

class Tab1InputScreen extends ConsumerWidget {
  const Tab1InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tab1InputProvider);
    final controller = ref.read(tab1InputProvider.notifier);
    List labels = Tab1InputLayout.labels;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.getFormattedDate(),
                style: timelyStyle,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(children: [
            const SizedBox(width: 10),
            SizedBox(
                width: 100,
                child: Text(Tab1InputLayout.scoreNames[0], style: timelyStyle)),
            ...List.generate(
              3,
              (index) {
                return Expanded(
                  child: Column(
                    children: [
                      Radio<int>(
                        value: state.fScore,
                        groupValue: index,
                        onChanged: (value) {
                          controller.setFScore(index);
                        },
                      ),
                      Text(labels[index])
                    ],
                  ),
                );
              },
            ),
          ]),
          Row(children: [
            const SizedBox(width: 10),
            SizedBox(
                width: 100,
                child: Text(Tab1InputLayout.scoreNames[1], style: timelyStyle)),
            ...List.generate(
              3,
              (index) {
                return Expanded(
                  child: Column(
                    children: [
                      Radio<int>(
                        value: state.mScore,
                        groupValue: index,
                        onChanged: (value) {
                          controller.setMScore(index);
                        },
                      ),
                      Text(labels[index])
                    ],
                  ),
                );
              },
            ),
          ]),
          Row(children: [
            const SizedBox(width: 10),
            SizedBox(
                width: 100,
                child: Text(Tab1InputLayout.scoreNames[2], style: timelyStyle)),
            ...List.generate(
              3,
              (index) {
                return Expanded(
                  child: Column(
                    children: [
                      Radio<int>(
                        value: state.sScore,
                        groupValue: index,
                        onChanged: (value) {
                          controller.setSScore(index);
                        },
                      ),
                      Text(labels[index])
                    ],
                  ),
                );
              },
            ),
          ]),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Next Update Time", style: timelyStyle),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? timeSelected = await showTimePicker(
                      context: context, initialTime: state.nextUpdateTime);
                  if (timeSelected != null) {
                    controller.setNextUpdateTime(timeSelected);
                  }
                },
                child: Column(
                  children: [
                    Text(state.nextUpdateTime.format(context)),
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
                child: TextFormField(
                  initialValue: state.text_1,
                  onChanged: (text_1) {
                    controller.setText_1(text_1);
                  },
                  textCapitalization: TextCapitalization.sentences,
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
        ],
      ),
    );
  }
}
