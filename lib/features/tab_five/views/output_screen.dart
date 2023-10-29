import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_five/controllers/output_controller.dart';
import 'package:timely/features/tab_five/views/input_screen.dart';
import 'package:timely/features/tab_one/controllers/color_provider.dart';
import 'package:timely/layout_params.dart';
import 'package:timely/general_providers/tab_index_provider.dart';

class TabFiveOutputScreen extends ConsumerWidget {
  const TabFiveOutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tabFiveFutureProvider);
    return provider.when(
        data: (data) {
          return Stack(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Divider(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        color: tabFiveAlternatingTileColors[index % 2],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(data[index].date,
                                  style: tabFiveOutputTileTextStyle),
                            ),
                            ...List.generate(3, (i) {
                              List scores = [
                                data[index].sScore,
                                data[index].pScore,
                                data[index].wScore
                              ];
                              List names = ["S", "P", "W"];
                              return Expanded(
                                child: Container(
                                  color: ref.read(colorProvider)[scores[i]],
                                  child: Center(
                                      child: Text("${names[i]} - ${scores[i]}",
                                          style: tabFiveOutputTileTextStyle)),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemCount: data.length,
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
                          child: Text(
                              "${DateTime.now().day}-${DateTime.now().month}"),
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
