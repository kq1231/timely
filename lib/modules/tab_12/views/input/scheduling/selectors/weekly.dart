import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';

class WeeklySelector extends ConsumerWidget {
  const WeeklySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab12SubEntryInputProvider);
    final controller = ref.read(tab12SubEntryInputProvider.notifier);

    final List<String> weekdays = "Mon,Tue,Wed,Thu,Fri,Sat,Sun".split(",");

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
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
                itemCount: 7,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (!provider.repetitions["Weekdays"].contains(index)) {
                          provider.repetitions["Weekdays"].add(index);
                          controller.setRepetitions(provider.repetitions);
                        } else {
                          provider.repetitions["Weekdays"]
                              .removeWhere((element) => element == index);
                          controller.setRepetitions(provider.repetitions);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: provider.repetitions["Weekdays"].contains(index)
                            ? Colors.orange
                            : Colors.lime,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        weekdays[index].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}