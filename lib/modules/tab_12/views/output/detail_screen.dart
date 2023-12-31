import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/views/input/sub_entry_input_screen.dart';
import 'package:timely/reusables.dart';

class Tab12DetailScreen extends ConsumerStatefulWidget {
  final Tab12EntryModel entry;

  const Tab12DetailScreen({super.key, required this.entry});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab12DetailScreenState();
}

class _Tab12DetailScreenState extends ConsumerState<Tab12DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab12OutputProvider);
    final controller = ref.read(tab12OutputProvider.notifier);

    return provider.when(
        data: (data) {
          Tab12EntryModel entry = widget.entry;
          List<Tab2Model> subEntries = data[entry]!;

          return Stack(
            children: [
              ListView(
                children: [
                  Container(
                    color: Colors.indigo[1200],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.activity),
                              Text(entry.importance.toString()),
                            ],
                          ),
                        ),
                        ...[
                          entry.objective,
                          entry.startDate.toString(),
                          entry.endDate.toString()
                        ]
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
                      Tab2Model subEntry = subEntries[subEntryIndex];
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
                                .read(tab12SubEntryInputProvider.notifier)
                                .setModel(subEntry);

                            await Future.delayed(
                                const Duration(milliseconds: 100), () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(),
                                    body: Tab12SubEntryInputScreen(
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
                                          subEntry.name,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            subEntry.startTime.format(context),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            subEntry
                                                .calculateEndTime(subEntry.dur)
                                                .join(":"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                          ref.invalidate(tab12SubEntryInputProvider);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(),
                                  body: Tab12SubEntryInputScreen(
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
        error: (_, __) => const Text("ERROR"),
        loading: () => const CircularProgressIndicator());
  }
}
