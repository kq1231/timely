import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_9/controllers/input/entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/views/input/entry_input_screen.dart';
import 'package:timely/modules/tab_9/views/output/detail_screen.dart';
import 'package:timely/reusables.dart';

class Tab9SummaryScreen extends ConsumerStatefulWidget {
  const Tab9SummaryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab9OutputScreenState();
}

class _Tab9OutputScreenState extends ConsumerState<Tab9SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab9OutputProvider);
    final controller = ref.read(tab9OutputProvider.notifier);

    return Stack(
      children: [
        provider.when(
          data: (data) {
            List<Tab9EntryModel> entries = data.keys.toList();
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 40,
                );
              },
              itemBuilder: (context, entryIndex) {
                Tab9EntryModel entry = entries[entryIndex];
                List<Tab9SubEntryModel> subEntries =
                    data.values.toList()[entryIndex];
                Tab9SubEntryModel lastSubEntry =
                    data.values.toList()[entryIndex].last;

                return DismissibleEntry(
                  entryKey: entry.uuid!,
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      controller.deleteEntry(entry);
                      data.removeWhere((k, v) => k.uuid == entry.uuid!);
                      setState(() {});
                    } else {
                      data.removeWhere((k, v) => k.uuid == entry.uuid!);
                      setState(() {});

                      controller.markEntryAsComplete(entry, subEntries);
                    }
                  },
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          ref
                              .read(tab9EntryInputProvider.notifier)
                              .setModel(entry);

                          await Future.delayed(
                              const Duration(milliseconds: 100), () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(),
                                  body: const Tab9EntryInputScreen(
                                    showSubEntryMolecule: false,
                                  ),
                                );
                              },
                            ));
                          });
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(entry.condition),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Care"),
                                  Text(entry.care),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Criticality"),
                                  Center(
                                      child:
                                          Text(entry.criticality.toString())),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Lesson Learnt"),
                                  Center(
                                      child:
                                          Text(entry.lessonLearnt.toString())),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(),
                                  body: Tab9DetailScreen(
                                    entry: entry,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat(DateFormat.ABBR_MONTH_DAY)
                                    .format(lastSubEntry.date),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(lastSubEntry.time),
                                  Text(lastSubEntry.task),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(lastSubEntry.description),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: entries.length,
            );
          },
          error: (_, __) => const Text("ERROR"),
          loading: () => const CircularProgressIndicator.adaptive(),
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
                    ref.invalidate(tab9EntryInputProvider);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(),
                            body: const Tab9EntryInputScreen(
                              showSubEntryMolecule: true,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        )
      ],
    );
  }
}
