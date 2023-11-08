import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_5/controllers/input_controller.dart';
import 'package:timely/modules/tab_5/controllers/output_controller.dart';

import 'package:timely/app_theme.dart';

class TabFiveInputScreen extends ConsumerWidget {
  const TabFiveInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final provider = ref.watch(tabFiveInputProvider.notifier);
    final tabFiveInput = ref.watch(tabFiveInputProvider);
    print("BUILD TRIGGERED");
    List<String> labels = ["Good", "Fair", "Poor"];

    // List scores = [model.sScore, model.pScore, model.wScore];
    return Column(
      children: [
        Text(
          tabFiveInput.date,
          style: timelyStyle,
        ),
        Row(children: [
          const SizedBox(width: 10),
          SizedBox(width: 100, child: Text('S Score', style: timelyStyle)),
          ...List.generate(
            3,
            (index) {
              return Expanded(
                child: Column(
                  children: [
                    Radio<int>(
                      value: tabFiveInput.sScore,
                      groupValue: index,
                      onChanged: (value) {
                        ref
                            .read(tabFiveInputProvider.notifier)
                            .setSScore(index);
                      },
                    ),
                    Text(labels[index]),
                  ],
                ),
              );
            },
          ),
        ]),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Text(
              'P Score',
              style: timelyStyle,
            ),
          ),
          ...List.generate(
            3,
            (index) {
              return Expanded(
                child: Column(
                  children: [
                    Radio<int>(
                      value: tabFiveInput.pScore,
                      groupValue: index,
                      onChanged: (value) {
                        ref
                            .read(tabFiveInputProvider.notifier)
                            .setPScore(index);
                      },
                    ),
                    Text(labels[index]),
                  ],
                ),
              );
            },
          ),
        ]),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(width: 10),
            SizedBox(width: 100, child: Text('W Score', style: timelyStyle)),
            ...List.generate(
              3,
              (index) {
                return Expanded(
                  child: Column(
                    children: [
                      Radio<int>(
                        value: tabFiveInput.wScore,
                        groupValue: index,
                        onChanged: (value) {
                          ref
                              .read(tabFiveInputProvider.notifier)
                              .setWScore(index);
                        },
                      ),
                      Text(labels[index]),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Weight",
                style: timelyStyle,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (weight) {
                  ref.read(tabFiveInputProvider.notifier).setWeight(weight);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(height: 10),
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
                ref.read(tabFiveInputProvider.notifier).syncToDB();
                ref.invalidate(tabFiveFutureProvider);
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
        )
      ],
    );
  }
}
