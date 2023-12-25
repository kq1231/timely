import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_9/controllers/input/entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/output_controller.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/views/input_screen/entry_input_screen.dart';
import 'package:timely/modules/tab_9/views/input_screen/sub_entry_input_screen.dart';
import 'package:timely/reusables.dart';

class Tab9OutputScreen extends ConsumerStatefulWidget {
  const Tab9OutputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab9OutputScreenState();
}

class _Tab9OutputScreenState extends ConsumerState<Tab9OutputScreen> {
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
                                  body: const Tab9EntryInputScreen(),
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
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 0,
                            thickness: 2,
                            color: Colors.black,
                          );
                        },
                        itemBuilder: (context, subEntryIndex) {
                          Tab9SubEntryModel subEntry =
                              subEntries[subEntryIndex];
                          return DismissibleEntry(
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                data[entry]!.removeWhere(
                                    (v) => v.uuid == subEntry.uuid);
                                controller.deleteSubEntry(
                                    entry.uuid!, subEntry);
                                setState(() {});
                              } else {
                                data[entry]!.removeWhere(
                                    (v) => v.uuid == subEntry.uuid);
                                setState(() {});

                                controller.markSubEntryAsComplete(
                                    entry, subEntry);
                              }
                            },
                            entryKey: subEntry.uuid!,
                            child: InkWell(
                              onTap: () async {
                                ref
                                    .read(tab9SubEntryInputProvider.notifier)
                                    .setModel(subEntry);

                                await Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Scaffold(
                                        appBar: AppBar(),
                                        body: Tab9SubEntryInputScreen(
                                          entryUuid: entry.uuid!,
                                        ),
                                      );
                                    },
                                  ));
                                });
                              },
                              child: Ink(
                                color: Colors.indigo,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        DateFormat(DateFormat.ABBR_MONTH_DAY)
                                            .format(subEntry.date),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(subEntry.time),
                                          Text(subEntry.task),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(subEntry.description),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: subEntries.length,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(0, 50),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  )),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    ref.invalidate(tab9SubEntryInputProvider);
                                    return Scaffold(
                                      appBar: AppBar(),
                                      body: Tab9SubEntryInputScreen(
                                          entryUuid: entry.uuid!),
                                    );
                                  },
                                ));
                              },
                              icon: const Icon(Icons.add),
                              label: const Text("Add Entry"),
                            ),
                          )
                        ],
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
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Scaffold(
                          appBar: AppBar(),
                          body: const Tab9EntryInputScreen(),
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
      ],
    );
  }
}
