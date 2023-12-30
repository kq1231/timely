import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/common/scheduling/controllers/input_controller.dart';
import 'package:timely/modules/common/scheduling/controllers/output_controller.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/common/scheduling/views/input_screen/input_screen.dart';
import 'package:timely/reusables.dart';

class OutputScreen extends ConsumerWidget {
  final bool? showEndTime;
  final AsyncNotifierProvider<Tab2OutputNotifier, List<Tab2Model>>
      tabOutputProvider;
  final int tabNumber;

  const OutputScreen({
    super.key,
    this.showEndTime,
    required this.tabOutputProvider,
    required this.tabNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tabOutputProvider);
    final controller = ref.read(tabOutputProvider.notifier);

    return provider.when(
        data: (models) {
          return Stack(
            children: [
              StatefulBuilder(builder: ((context, setState) {
                return ListView(
                  children: [
                    // Header Row
                    // SizedBox(
                    //   height: 50,
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 3,
                    //         child: Container(
                    //           height: 50,
                    //           color: Colors.indigo[300],
                    //           child: const Row(
                    //             children: [
                    //               Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Text("Activities"),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           color: Colors.indigo[400],
                    //           child: const Padding(
                    //             padding: EdgeInsets.all(8.0),
                    //             child: Center(child: Text("Start")),
                    //           ),
                    //         ),
                    //       ),
                    //       showEndTime == false
                    //           ? Container()
                    //           : Expanded(
                    //               child: Container(
                    //                   color: Colors.indigo[500],
                    //                   child: const Padding(
                    //                     padding: EdgeInsets.all(8.0),
                    //                     child: Center(child: Text("End")),
                    //                   )),
                    //             )
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 1,
                    ),
                    ...List.generate(
                      models.length,
                      (i) {
                        Tab2Model model = models[i];
                        List<int> endTime = model.calculateEndTime(model.dur);

                        return DismissibleEntry(
                          entryKey: model.uuid!,
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              controller.deleteModel(model);
                              models.removeWhere(
                                  (element) => element.uuid == model.uuid);
                              setState(() {});
                            } else {
                              models.removeWhere((e) => e.uuid == model.uuid);
                              setState(() {});

                              controller.markModelAsComplete(model);
                            }
                          },
                          key: Key(model
                              .uuid!), // ! is used when you are sure that the nullable field will never be null
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 60),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.indigo[700],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .read(tab2InputProvider.notifier)
                                        .setModel(model);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Scaffold(
                                            body: showEndTime == false
                                                ? Tab2InputScreen(
                                                    showDuration: false,
                                                    tabNumber: tabNumber,
                                                  )
                                                : Tab2InputScreen(
                                                    tabNumber: tabNumber,
                                                  ),
                                            appBar: AppBar(),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            model.name,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            DateFormat("h:mm a").format(
                                              DateTime(
                                                  0,
                                                  0,
                                                  0,
                                                  model.startTime.hour,
                                                  model.startTime.minute),
                                            ),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      showEndTime == false
                                          ? Container()
                                          : Expanded(
                                              child: Center(
                                                child: Text(
                                                  DateFormat("h:mm a").format(
                                                    DateTime(0, 0, 0,
                                                        endTime[0], endTime[1]),
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              })),
              Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        heroTag: null,
                        child: const Icon(Icons.home),
                        onPressed: () {
                          ref.read(tabIndexProvider.notifier).setIndex(12);
                        },
                      ),
                      FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons
                              .add), // Text(DateTime.now().toString().substring(5, 10)),
                          onPressed: () {
                            ref.invalidate(tab2InputProvider);
                            if (showEndTime != false) {
                              ref.read(tab2InputProvider.notifier).setEndTime(
                                  const Duration(hours: 0, minutes: 30));
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(),
                                    body: showEndTime == false
                                        ? Tab2InputScreen(
                                            tabNumber: tabNumber,
                                            showDuration: false,
                                          )
                                        : Tab2InputScreen(
                                            tabNumber: tabNumber,
                                          ),
                                  );
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              )
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
