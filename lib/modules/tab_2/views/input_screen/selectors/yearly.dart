import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/controllers/input_controller.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';

class YearlySelector extends ConsumerWidget {
  const YearlySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> months =
        "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec".split(",");
    final List sliderNames = [
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

    final provider = ref.watch(tab2InputProvider);
    final controller = ref.read(tab2InputProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          // Add and remove the dates
                          if (!provider.repetitions[0].contains(index)) {
                            controller.setRepetitions(
                              [
                                [...provider.repetitions[0], index],
                                provider.repetitions[1]
                              ],
                            );
                          } else {
                            controller.setRepetitions([
                              [
                                ...provider.repetitions[0]
                                  ..removeWhere((element) => element == index)
                              ],
                              provider.repetitions[1]
                            ]);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: provider.repetitions[0].contains(index)
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          months[index].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: provider.repetitions[0].contains(index)
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
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Days of Week"),
              Switch(
                  value: provider.basis == Basis.day ? true : false,
                  onChanged: (val) {
                    controller.setBasis(val == true ? Basis.day : Basis.date);
                    if (val) {
                      controller.setRepetitions([
                        provider.repetitions[0],
                        [0, 0]
                      ]);
                    } else {
                      controller.setRepetitions([provider.repetitions[0], []]);
                    }
                  })
            ],
          ),
          provider.basis == Basis.day
              ? Column(
                  children: [
                    Slider(
                        max: 5,
                        divisions: 5,
                        label: sliderNames[0][provider.repetitions[1][0]],
                        value: provider.repetitions[1][0].toDouble(),
                        onChanged: (val) {
                          controller.setRepetitions([
                            provider.repetitions[0],
                            [val.toInt(), provider.repetitions[1][1]]
                          ]);
                        }),
                    Slider(
                        max: 6,
                        divisions: 6,
                        label: sliderNames[1][provider.repetitions[1][1]],
                        value: provider.repetitions[1][1].toDouble(),
                        onChanged: (val) {
                          controller.setRepetitions([
                            provider.repetitions[0],
                            [provider.repetitions[1][0], val.toInt()],
                          ]);
                        }),
                    Text(
                      sliderNames[0][provider.repetitions[1][0]] +
                          " " +
                          sliderNames[1][provider.repetitions[1][1]],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
