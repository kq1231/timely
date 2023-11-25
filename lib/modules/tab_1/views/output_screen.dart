import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/controllers/output_controller.dart';
import 'package:timely/modules/tab_1/views/input_screen.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/reusables.dart';

class Tab1OutputScreen extends ConsumerWidget {
  const Tab1OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tabOneFutureProvider);
    return provider.when(
        data: (data) {
          return Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 70,
                            child: Center(
                                child: Text(
                              Tab1OutputLayout.headers[0],
                              style: Tab1OutputLayout.headerFont,
                            ))),
                        Expanded(
                            child: Center(
                                child: Text(
                          Tab1OutputLayout.headers[1],
                          style: Tab1OutputLayout.headerFont,
                        ))),
                        Expanded(
                            child: Center(
                                child: Text(
                          Tab1OutputLayout.headers[2],
                          style: Tab1OutputLayout.headerFont,
                        ))),
                        Expanded(
                            child: Center(
                                child: Text(
                          Tab1OutputLayout.headers[3],
                          style: Tab1OutputLayout.headerFont,
                        ))),
                        SizedBox(
                            width: 70,
                            child: Center(
                                child: Text(
                              Tab1OutputLayout.headers[4],
                              style: Tab1OutputLayout.headerFont,
                            ))),
                      ],
                    ),
                  ),
                  ...List.generate(data.length, (index) {
                    var time = TimeOfDay(
                        hour: (data[index].nextUpdateTime.hour % 12) + 1,
                        minute: data[index].nextUpdateTime.minute);
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Container(
                            color: index % 2 == 0
                                ? Tab1OutputLayout.alternateColors[0]
                                : Tab1OutputLayout.alternateColors[1],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(data[index].date,
                                        style: Tab1OutputLayout.tileFont),
                                  ),
                                ),
                                ...List.generate(3, (i) {
                                  List scores = [
                                    data[index].fScore,
                                    data[index].mScore,
                                    data[index].sScore
                                  ];
                                  return Expanded(
                                    child: Center(
                                        child: Text("${scores[i]}",
                                            style: Tab1OutputLayout.tileFont)),
                                  );
                                }),
                                SizedBox(
                                    width: 70,
                                    child: Center(
                                        child: Text(
                                      "${time.hour < 10 ? '0' : ''}${time.hour}:${time.minute < 10 ? '0' : ''}${time.minute} ${data[index].nextUpdateTime.hour > 12 ? 'PM' : 'AM'}",
                                      style: Tab1OutputLayout.tileFont,
                                    ))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                            heroTag: null,
                            child: const Icon(Icons.home),
                            onPressed: () {
                              ref.read(tabIndexProvider.notifier).setIndex(12);
                            }),
                        FloatingActionButton(
                            heroTag: null,
                            child: const Icon(Icons.add),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Scaffold(
                                        appBar: AppBar(),
                                        body: const TabOneInputScreen());
                                  },
                                ),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
