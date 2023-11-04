import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/controllers/output_controller.dart';
import 'package:timely/modules/tab_1/views/tab_one_input_screen.dart';
import 'package:timely/app_themes.dart';
import 'package:timely/reusables.dart';

class TabOneOutputScreen extends ConsumerWidget {
  const TabOneOutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tabOneFutureProvider);
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
                            width: 110,
                            child: Center(
                                child: Text(
                              TabOneLayout.headers[0],
                              style: TabOneLayout.headerFont,
                            ))),
                        Expanded(
                            child: Center(
                                child: Text(
                          TabOneLayout.headers[1],
                          style: TabOneLayout.headerFont,
                        ))),
                        Expanded(
                            child: Center(
                                child: Text(
                          TabOneLayout.headers[2],
                          style: TabOneLayout.headerFont,
                        ))),
                        Expanded(
                            child: Center(
                                child: Text(
                          TabOneLayout.headers[3],
                          style: TabOneLayout.headerFont,
                        ))),
                        SizedBox(
                            width: 70,
                            child: Center(
                                child: Text(
                              TabOneLayout.headers[4],
                              style: TabOneLayout.headerFont,
                            ))),
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
                                  ? TabOneLayout.alternateColors[0]
                                  : TabOneLayout.alternateColors[1],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(data[index].date,
                                          style: TabOneLayout.tileFont),
                                    ),
                                  ),
                                  ...List.generate(3, (i) {
                                    List scores = [
                                      data[index].fScore,
                                      data[index].mScore,
                                      data[index].sScore
                                    ];
                                    return Expanded(
                                      child: Container(
                                        child: Center(
                                            child: Text("${scores[i]}",
                                                style: TabOneLayout.tileFont)),
                                      ),
                                    );
                                  }),
                                  SizedBox(
                                      width: 70,
                                      child: Center(
                                          child: Text(
                                        data[index]
                                            .nextUpdateTime
                                            .format(context),
                                        style: TabOneLayout.tileFont,
                                      ))),
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
                          child: Text(
                              "${DateTime.now().day}-${DateTime.now().month}"),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                  appBar: AppBar(),
                                  body: const TabOneInputScreen());
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
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
