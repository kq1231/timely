import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/controllers/input/entry_input_controller.dart';

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

    final provider = ref.watch(tab12EntryInputProvider);
    final controller = ref.read(tab12EntryInputProvider.notifier);

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
                          if (!provider.tab2Model.repetitions["Months"]
                              .contains(index + 1)) {
                            provider.tab2Model.repetitions["Months"]
                                .add(index + 1);
                            controller
                                .setRepetitions(provider.tab2Model.repetitions);
                          } else {
                            provider.tab2Model.repetitions["Months"]
                                .removeWhere((element) => element == index + 1);
                            controller
                                .setRepetitions(provider.tab2Model.repetitions);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: provider.tab2Model.repetitions["Months"]
                                  .contains(index + 1)
                              ? Colors.blue
                              : Colors.blueGrey,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          months[index].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: provider.tab2Model.repetitions["Months"]
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
                  value: provider.tab2Model.basis == Basis.day ? true : false,
                  onChanged: (val) {
                    controller.setBasis(val == true ? Basis.day : Basis.date);
                    if (val) {
                      controller.setRepetitions({
                        "Months": provider.tab2Model.repetitions["Months"],
                        "DoW": [0, 0],
                      });
                    } else {
                      controller.setRepetitions({
                        "Months": provider.tab2Model.repetitions["Months"],
                      });
                    }
                  })
            ],
          ),
          provider.tab2Model.basis == Basis.day
              ? Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 150,
                        child: CupertinoPicker(
                          squeeze: 1.45,
                          scrollController: FixedExtentScrollController(
                            initialItem: provider.tab2Model.repetitions["DoW"]
                                [0],
                          ),
                          itemExtent: 60,
                          onSelectedItemChanged: (item) {
                            provider.tab2Model.repetitions["DoW"].first =
                                item.toInt();
                            controller
                                .setRepetitions(provider.tab2Model.repetitions);
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
                            initialItem: provider.tab2Model.repetitions["DoW"]
                                [1],
                          ),
                          itemExtent: 60,
                          onSelectedItemChanged: (item) {
                            provider.tab2Model.repetitions["DoW"].last =
                                item.toInt();
                            controller
                                .setRepetitions(provider.tab2Model.repetitions);
                          },
                          children: List<Widget>.generate(
                              sliderNames.last.length,
                              (index) =>
                                  Center(child: Text(sliderNames.last[index]))),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
