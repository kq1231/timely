import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/controllers/input_controller.dart';
import 'package:timely/app_theme.dart';

class TabOneInputScreen extends ConsumerWidget {
  const TabOneInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tabOneInputProvider);
    final controller = ref.read(tabOneInputProvider.notifier);
    List labels = TabOneInputLayout.labels;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.date,
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
                child:
                    Text(TabOneInputLayout.scoreNames[0], style: timelyStyle)),
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
                child:
                    Text(TabOneInputLayout.scoreNames[1], style: timelyStyle)),
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
                child:
                    Text(TabOneInputLayout.scoreNames[2], style: timelyStyle)),
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
              Text(TabOneInputLayout.text_1Name, style: timelyStyle),
              const SizedBox(width: 20),
              SizedBox(
                width: 250,
                child: TextField(
                  onChanged: (text_1) {
                    controller.setText_1(text_1);
                  },
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
                  ref.invalidate(tabOneInputProvider);
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
