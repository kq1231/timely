import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_5/controllers/input_controller.dart';
import 'package:timely/modules/tab_5/controllers/output_controller.dart';

import 'package:timely/app_theme.dart';

class Tab5InputScreen extends ConsumerWidget {
  const Tab5InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(tab5InputProvider.notifier);
    final provider = ref.watch(tab5InputProvider);
    List<String> labels = Tab5InputLayout.labels;

    // List scores = [model.sScore, model.pScore, model.wScore];
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            controller.getFormattedDate(),
            style: Tab5InputLayout.dateStyle,
          ),
          Row(children: [
            const SizedBox(width: 10),
            SizedBox(
                width: 100,
                child: Text(
                  Tab5InputLayout.scoreNames[0],
                  style: Tab5InputLayout.scoreNamesStyle,
                )),
            ...List.generate(
              3,
              (index) {
                return Expanded(
                  child: Column(
                    children: [
                      Radio<int>(
                        value: provider.sScore,
                        groupValue: index,
                        onChanged: (value) {
                          ref.read(tab5InputProvider.notifier).setSScore(index);
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
                Tab5InputLayout.scoreNames[1],
                style: Tab5InputLayout.scoreNamesStyle,
              ),
            ),
            ...List.generate(
              3,
              (index) {
                return Expanded(
                  child: Column(
                    children: [
                      Radio<int>(
                        value: provider.pScore,
                        groupValue: index,
                        onChanged: (value) {
                          ref.read(tab5InputProvider.notifier).setPScore(index);
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
              SizedBox(
                width: 100,
                child: Text(
                  Tab5InputLayout.scoreNames[2],
                  style: Tab5InputLayout.scoreNamesStyle,
                ),
              ),
              ...List.generate(
                3,
                (index) {
                  return Expanded(
                    child: Column(
                      children: [
                        Radio<int>(
                          value: provider.wScore,
                          groupValue: index,
                          onChanged: (value) {
                            ref
                                .read(tab5InputProvider.notifier)
                                .setWScore(index);
                          },
                        ),
                        Text(
                          labels[index],
                          style: Tab5InputLayout.labelStyle,
                        ),
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
                  Tab5InputLayout.weightFieldName,
                  style: Tab5InputLayout.weightFieldStyle,
                ),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: provider.weight.toString(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (weight) {
                    ref.read(tab5InputProvider.notifier).setWeight(weight);
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
                  child: Text(
                    Tab5InputLayout.cancelButtonText,
                    style: Tab5InputLayout.cancelButtonStyle,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              ElevatedButton(
                child: Text(
                  Tab5InputLayout.submitButtonText,
                  style: Tab5InputLayout.submitButtonStyle,
                ),
                onPressed: () {
                  ref.read(tab5InputProvider.notifier).syncToDB();
                  ref.invalidate(tab5FutureProvider);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        Tab5InputLayout.submissionStatusMessage,
                        style: Tab5InputLayout.submissionStatusMessageStyle,
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
