import 'package:flutter/cupertino.dart';
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
          SizedBox(
            width: 170,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                controller.getFormattedDate(),
                style: Tab5InputLayout.dateStyle,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(Tab1InputLayout.scoreNames[0]),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.indigo[800],
                    child: SizedBox(
                      height: 120,
                      child: CupertinoPicker(
                        selectionOverlay: Container(
                          color: const Color.fromARGB(78, 33, 149, 243),
                        ),
                        itemExtent: 50,
                        scrollController: FixedExtentScrollController(
                            initialItem: provider.sScore),
                        onSelectedItemChanged: (index) {
                          controller.setSScore(index);
                        },
                        children:
                            labels.map((e) => Center(child: Text(e))).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(Tab1InputLayout.scoreNames[1]),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.indigo[600],
                        child: SizedBox(
                          height: 120,
                          child: CupertinoPicker(
                            itemExtent: 50,
                            selectionOverlay: Container(
                              color: const Color.fromARGB(78, 33, 149, 243),
                            ),
                            scrollController: FixedExtentScrollController(
                                initialItem: provider.pScore),
                            onSelectedItemChanged: (index) {
                              controller.setPScore(index);
                            },
                            children: labels
                                .map((e) => Center(child: Text(e)))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(Tab1InputLayout.scoreNames[2]),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.indigo[800],
                    child: SizedBox(
                      height: 120,
                      child: CupertinoPicker(
                        itemExtent: 50,
                        selectionOverlay: Container(
                          color: const Color.fromARGB(78, 33, 149, 243),
                        ),
                        scrollController: FixedExtentScrollController(
                            initialItem: provider.wScore),
                        onSelectedItemChanged: (index) {
                          controller.setWScore(index);
                        },
                        children:
                            labels.map((e) => Center(child: Text(e))).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
          const Divider(
            height: 80,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: provider.weight.toString() != "0.0"
                      ? provider.weight.toString()
                      : "",
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    filled: true,
                    hintText: "Weight",
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
                  child: Text(
                    Tab5InputLayout.cancelButtonText,
                    style: Tab5InputLayout.cancelButtonStyle,
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
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
