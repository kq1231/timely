import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_8/controllers/filter_controller.dart';
import 'package:timely/modules/tab_8/controllers/input_controller.dart';
import 'package:timely/modules/tab_8/controllers/output_controller.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';
import 'package:timely/modules/tab_8/views/input_screen.dart';
import 'package:timely/reusables.dart';

class Tab8OutputScreen extends ConsumerStatefulWidget {
  const Tab8OutputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab8OutputScreenState();
}

class _Tab8OutputScreenState extends ConsumerState<Tab8OutputScreen> {
  Set<int> lsjSelections = {0};
  Set<int> prioritySelections = {0};

  @override
  Widget build(BuildContext context) {
    final filterProv = ref.watch(filterProvider);
    final filterCont = ref.read(filterProvider.notifier);
    final modelsProv = ref.watch(tab8OutputProvider);
    final modelsCont = ref.read(tab8OutputProvider.notifier);

    return Stack(children: [
      ListView(
        children: [
          // Segmented Buttons
          Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      child: SegmentedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide.none,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        segments: const [
                          ButtonSegment(
                            value: 0,
                            label: Text("L"),
                          ),
                          ButtonSegment(
                            value: 1,
                            label: Text("S"),
                          ),
                          ButtonSegment(
                            value: 2,
                            label: Text("J"),
                          ),
                        ],
                        selected: filterProv["LSJ"],
                        onSelectionChanged: (Set<int> newSelections) {
                          filterCont.state["LSJ"] = newSelections;
                          setState(() {});
                        },
                        multiSelectionEnabled: true,
                        emptySelectionAllowed: true,
                        showSelectedIcon: false,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Flexible(
                child: Row(
                  children: [
                    Flexible(
                      child: SegmentedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide.none,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        segments: const [
                          ButtonSegment(
                            value: 0,
                            label: Text("H"),
                          ),
                          ButtonSegment(
                            value: 1,
                            label: Text("M"),
                          ),
                          ButtonSegment(
                            value: 2,
                            label: Text("L"),
                          ),
                        ],
                        selected: filterProv["HML"],
                        onSelectionChanged: (Set<int> newSelections) {
                          filterCont.state["HML"] = newSelections;
                          setState(() {});
                        },
                        multiSelectionEnabled: true,
                        emptySelectionAllowed: true,
                        showSelectedIcon: false,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            height: 0,
          ),

          modelsProv.when(
              data: (models) {
                // Filter out models
                List filteredModels = models.where((model) {
                  if (filterProv["LSJ"].length + filterProv["HML"].length ==
                      0) {
                    return true;
                  } else {
                    return filterProv["HML"].contains(model.hml) &&
                        filterProv["LSJ"].contains(model.lsj);
                  }
                }).toList();
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Tab8Model model = filteredModels[index];
                    return DismissibleEntry(
                      entryKey: model.uuid!,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          modelsCont.deleteModel(model);
                          models.removeWhere(
                              (element) => element.uuid == model.uuid);
                          setState(() {});
                        } else {
                          models.removeWhere((e) => e.uuid == model.uuid);
                          setState(() {});
                          modelsCont.markModelAsComplete(model);
                        }
                      },
                      child: InkWell(
                        onTap: () {
                          ref.read(tab8InputProvider.notifier).setModel(model);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(),
                                body: const Tab8InputScreen(),
                              );
                            },
                          ));
                        },
                        child: Container(
                          color: Colors.indigo,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat(DateFormat.ABBR_MONTH_DAY)
                                          .format(model.date),
                                    ),
                                    Text(model.title),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Wrap(
                                    children: [
                                      Text(model.description),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 0,
                                color: Colors.black,
                                thickness: 2,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: filteredModels.length,
                );
              },
              error: (_, __) => const Text("ERROR"),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))
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
                    ref.invalidate(tab8InputProvider);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: const Tab8InputScreen(),
                      );
                    }));
                  }),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      )
    ]);
  }
}
