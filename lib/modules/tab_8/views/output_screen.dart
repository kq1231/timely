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

    return Stack(children: [
      ListView(
        children: [
          // Segmented Buttons
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton(
                      style: ElevatedButton.styleFrom(
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
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton(
                      style: ElevatedButton.styleFrom(
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
                    ),
                  ),
                ],
              )
            ],
          ),
          const Divider(),
          modelsProv.when(
              data: (models) {
                // Filter out models
                models = models.where((model) {
                  if (filterProv["LSJ"].length + filterProv["HML"].length ==
                      0) {
                    return true;
                  } else {
                    return filterProv["HML"].contains(model.hml) &&
                        filterProv["LSJ"].contains(model.lsj);
                  }
                }).toList();
                print(models);
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Tab8Model model = models[index];
                    return Container(
                      color: Colors.indigo,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: Row(
                              children: [Text(model.description)],
                            ),
                          ),
                          const Divider(
                            height: 0,
                            color: Colors.black,
                            thickness: 2,
                          )
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: models.length,
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
