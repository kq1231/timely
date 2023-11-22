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
                          if (!provider.repetitions["Months"]
                              .contains(index + 1)) {
                            provider.repetitions["Months"].add(index + 1);
                            controller.setRepetitions(provider.repetitions);
                          } else {
                            provider.repetitions["Months"]
                                .removeWhere((element) => element == index + 1);
                            controller.setRepetitions(provider.repetitions);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color:
                              provider.repetitions["Months"].contains(index + 1)
                                  ? Colors.blue
                                  : Colors.blueGrey,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          months[index].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: provider.repetitions["Months"]
                                    .contains(index + 1)
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
                      controller.setRepetitions({
                        "Months": provider.repetitions["Months"],
                        "DoW": [0, 0],
                      });
                    } else {
                      controller.setRepetitions({
                        "Months": provider.repetitions["Months"],
                      });
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
                        label: sliderNames
                            .first[provider.repetitions["DoW"].first],
                        value: provider.repetitions["DoW"].first.toDouble(),
                        onChanged: (val) {
                          provider.repetitions["DoW"].first = val.toInt();
                          controller.setRepetitions(provider.repetitions);
                        }),
                    Slider(
                        max: 6,
                        divisions: 6,
                        label:
                            sliderNames.last[provider.repetitions["DoW"].last],
                        value: provider.repetitions["DoW"].last.toDouble(),
                        onChanged: (val) {
                          provider.repetitions["DoW"].last = val.toInt();
                          controller.setRepetitions(provider.repetitions);
                        }),
                    Text(
                      sliderNames.first[provider.repetitions["DoW"].first] +
                          " " +
                          sliderNames.last[provider.repetitions["DoW"].last],
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
