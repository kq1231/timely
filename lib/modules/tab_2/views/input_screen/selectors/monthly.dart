import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/controllers/input_controller.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';

class MonthlySelector extends ConsumerWidget {
  const MonthlySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab2InputProvider);
    final controller = ref.read(tab2InputProvider.notifier);

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

    return Column(
      children: [
        CheckboxListTile(
            title: const Text("Each"),
            value: provider.basis == Basis.date ? true : false,
            onChanged: (val) {
              controller.setBasis(val == true ? Basis.date : null);
            }),
        CheckboxListTile(
            title: const Text("On the..."),
            value: provider.basis == Basis.day ? true : false,
            onChanged: (val) {
              controller.setBasis(val == true ? Basis.day : null);
              controller.setRepetitions([0, 0]);
            }),
        provider.basis == Basis.date
            ? StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                      ),
                      itemCount: 31,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (!provider.repetitions.contains(index + 1)) {
                                controller.setRepetitions(
                                    [...provider.repetitions, index + 1]);
                              } else {
                                controller.setRepetitions(provider.repetitions
                                  ..removeWhere(
                                      (element) => element == index + 1));
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: provider.repetitions.contains(index + 1)
                                  ? Colors.blue
                                  : Colors.blueGrey,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: provider.repetitions.contains(index + 1)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            : Column(
                children: [
                  Slider(
                      max: 5,
                      divisions: 5,
                      label: sliderNames[0][provider.repetitions[0]],
                      value: provider.repetitions[0].toDouble(),
                      onChanged: (val) {
                        controller.setRepetitions(
                            [val.toInt(), provider.repetitions[1]]);
                      }),
                  Slider(
                      max: 6,
                      divisions: 6,
                      label: sliderNames[1][provider.repetitions[1]],
                      value: provider.repetitions[1].toDouble(),
                      onChanged: (val) {
                        controller.setRepetitions(
                            [provider.repetitions[0], val.toInt()]);
                      }),
                  Text(
                    sliderNames[0][provider.repetitions[0]] +
                        " " +
                        sliderNames[1][provider.repetitions[1]],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
      ],
    );
  }
}
