import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2_6_7/controllers/input_controller.dart';
import 'package:timely/modules/tab_2_6_7/models/tab_2_model.dart';

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
              controller.setRepetitions({"Dates": []});
            }),
        CheckboxListTile(
            title: const Text("On the..."),
            value: provider.basis == Basis.day ? true : false,
            onChanged: (val) {
              controller.setBasis(val == true ? Basis.day : null);
              controller.setRepetitions({
                "DoW": [0, 0]
              });
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
                              if (!provider.repetitions["Dates"]
                                  .contains(index + 1)) {
                                provider.repetitions["Dates"].add(index + 1);
                                controller.setRepetitions(provider.repetitions);
                              } else {
                                provider.repetitions["Dates"].removeWhere(
                                    (element) => element == index + 1);
                                controller.setRepetitions(provider.repetitions);
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: provider.repetitions["Dates"]
                                      .contains(index + 1)
                                  ? Colors.blue
                                  : Colors.blueGrey,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: provider.repetitions["Dates"]
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
              )
            : provider.basis == Basis.day
                ? Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: CupertinoPicker(
                            squeeze: 1.45,
                            scrollController: FixedExtentScrollController(
                              initialItem: provider.repetitions["DoW"][0],
                            ),
                            itemExtent: 60,
                            onSelectedItemChanged: (item) {
                              provider.repetitions["DoW"].first = item.toInt();
                              controller.setRepetitions(provider.repetitions);
                            },
                            children: List<Widget>.generate(
                                sliderNames.first.length,
                                (index) => Center(
                                    child: Text(sliderNames.first[index]))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 150,
                          child: CupertinoPicker(
                            squeeze: 1.45,
                            scrollController: FixedExtentScrollController(
                              initialItem: provider.repetitions["DoW"][1],
                            ),
                            itemExtent: 60,
                            onSelectedItemChanged: (item) {
                              provider.repetitions["DoW"].last = item.toInt();
                              controller.setRepetitions(provider.repetitions);
                            },
                            children: List<Widget>.generate(
                                sliderNames.last.length,
                                (index) => Center(
                                    child: Text(sliderNames.last[index]))),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
      ],
    );
  }
}
