import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_9/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';
import 'package:timely/modules/tab_9/views/input/sub_entry_input_screen.dart';
import 'package:timely/reusables.dart';

class Tab9DetailScreen extends ConsumerStatefulWidget {
  final Tab9EntryModel entry;

  const Tab9DetailScreen({super.key, required this.entry});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab9DetailScreenState();
}

class _Tab9DetailScreenState extends ConsumerState<Tab9DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab9OutputProvider);
    final controller = ref.read(tab9OutputProvider.notifier);

    return provider.when(
        data: (data) {
          Tab9EntryModel entry = widget.entry;
          print(entry.hashCode);
          List<Tab9SubEntryModel> subEntries = data[entry]!;

          return Stack(
            children: [
              ListView(
                children: [
                  Container(
                    color: Colors.indigo[900],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.condition),
                              Text(entry.criticality.toString()),
                            ],
                          ),
                        ),
                        ...[entry.care, entry.lessonLearnt]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(child: Text(e)),
                                    ],
                                  ),
                                ))
                            .toList()
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 0,
                        thickness: 2,
                        color: Colors.black,
                      );
                    },
                    itemBuilder: (context, subEntryIndex) {
                      Tab9SubEntryModel subEntry = subEntries[subEntryIndex];
                      return DismissibleEntry(
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            subEntries
                                .removeWhere((v) => v.uuid == subEntry.uuid);
                            controller.deleteSubEntry(entry.uuid!, subEntry);
                            setState(() {});
                          } else {
                            subEntries
                                .removeWhere((v) => v.uuid == subEntry.uuid);
                            setState(() {});

                            controller.markSubEntryAsComplete(entry, subEntry);
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          subEntry.task,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            DateFormat(
                                                    DateFormat.ABBR_MONTH_DAY)
                                                .format(subEntry.date),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            subEntry.time,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: Text(subEntry.description)),
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
                  )
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
                        child: const Icon(Icons.add),
                        onPressed: () {
                          ref.invalidate(tab9SubEntryInputProvider);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(),
                                  body: Tab9SubEntryInputScreen(
                                    entryUuid: entry.uuid!,
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
        },
        error: (_, __) => Text("ERROR"),
        loading: () => CircularProgressIndicator());
  }
}
