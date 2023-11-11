import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_5/controllers/output_controller.dart';
import 'package:timely/modules/tab_5/views/input_screen.dart';
import 'package:timely/reusables.dart';
import 'package:timely/app_theme.dart';

class Tab5OutputScreen extends ConsumerWidget {
  const Tab5OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tabFiveFutureProvider);
    return provider.when(
        data: (data) {
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: Center(child: Text("Date")),
                        ),
                        Expanded(child: Center(child: Text("S"))),
                        Expanded(child: Center(child: Text("P"))),
                        Expanded(child: Center(child: Text("W"))),
                        SizedBox(
                            width: 70, child: Center(child: Text("Weight"))),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.blueGrey[800]
                                  : Colors.grey[800],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(data[index].date,
                                          style: tabFiveOutputTileTextStyle),
                                    ),
                                  ),
                                  ...List.generate(3, (i) {
                                    List scores = [
                                      data[index].sScore,
                                      data[index].pScore,
                                      data[index].wScore
                                    ];
                                    return Expanded(
                                      child: Container(
                                        color: ref
                                            .read(colorProvider)[scores[i] * 3],
                                        child: Center(
                                            child: Text("${scores[i]}",
                                                style:
                                                    tabFiveOutputTileTextStyle)),
                                      ),
                                    );
                                  }),
                                  SizedBox(
                                      width: 70,
                                      child: Center(
                                          child: Text(
                                              "${data[index].weight} kg"))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: data.length,
                  ),
                ],
              ),
              Column(
                children: [
                  const Spacer(),
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
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                  appBar: AppBar(),
                                  body: const TabFiveInputScreen());
                            }));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const CircularProgressIndicator());
  }
}
