import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_one_re/controllers/input_controller.dart';
import 'package:timely/layout_params.dart';

class TabOneInputScreen extends ConsumerWidget {
  const TabOneInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tabOneInputProvider);
    final controller = ref.read(tabOneInputProvider.notifier);

    return Column(
      children: [
        Text(
          state.date,
          style: timelyStyle,
        ),
        Row(children: [
          const SizedBox(width: 10),
          SizedBox(width: 100, child: Text('F Score', style: timelyStyle)),
          ...List.generate(
            3,
            (index) {
              return Expanded(
                child: Radio<int>(
                  value: state.fScore,
                  groupValue: index,
                  onChanged: (value) {
                    controller.setFScore(index);
                  },
                ),
              );
            },
          ),
        ]),
        Row(children: [
          const SizedBox(width: 10),
          SizedBox(width: 100, child: Text('M Score', style: timelyStyle)),
          ...List.generate(
            3,
            (index) {
              return Expanded(
                child: Radio<int>(
                  value: state.mScore,
                  groupValue: index,
                  onChanged: (value) {
                    controller.setMScore(index);
                  },
                ),
              );
            },
          ),
        ]),
        Row(children: [
          const SizedBox(width: 10),
          SizedBox(width: 100, child: Text('S Score', style: timelyStyle)),
          ...List.generate(
            3,
            (index) {
              return Expanded(
                child: Radio<int>(
                  value: state.sScore,
                  groupValue: index,
                  onChanged: (value) {
                    controller.setSScore(index);
                  },
                ),
              );
            },
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: const Icon(Icons.timer),
            ),
          ],
        ),
        Row(
          children: [
            Text("Text 1", style: timelyStyle),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                onChanged: (text_1) {
                  print(text_1);
                  controller.setText_1(text_1);
                },
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(child: const Text("Cancel"), onPressed: () {}),
            ElevatedButton(
              child: const Text("Submit"),
              onPressed: () {
                controller.syncToDB();
                ref.invalidate(tabOneInputProvider);
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
    );
  }
}
