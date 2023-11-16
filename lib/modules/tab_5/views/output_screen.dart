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
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Tab5OutputLayout.spacings[0],
                          child: Center(
                            child: Text(Tab5OutputLayout.headers[0]),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(Tab5OutputLayout.headers[1]),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(Tab5OutputLayout.headers[2]),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(Tab5OutputLayout.headers[3]),
                          ),
                        ),
                        SizedBox(
                            width: Tab5OutputLayout.spacings[1],
                            child: Center(
                                child: Text(Tab5OutputLayout.headers[4]))),
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
                                  ? Tab5OutputLayout.alternatingColors[0]
                                  : Tab5OutputLayout.alternatingColors[1],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        data[index].date,
                                        style: Tab5OutputLayout
                                            .tabFiveOutputTileTextStyle,
                                      ),
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
                                          child: Text(
                                            "${scores[i]}",
                                            style: Tab5OutputLayout
                                                .tabFiveOutputTileTextStyle,
                                          ),
                                        ),
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
                  SizedBox(
                    height: Tab5OutputLayout.spacings[2],
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
