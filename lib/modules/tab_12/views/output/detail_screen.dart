import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';
import 'package:timely/modules/tab_12/views/input/sub_entry_input_screen.dart';
import 'package:timely/reusables.dart';

class Tab12DetailScreen extends ConsumerStatefulWidget {
  final int entryIndex;

  const Tab12DetailScreen({super.key, required this.entryIndex});

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
          Tab12EntryModel entry = data.keys.toList()[widget.entryIndex];
          List<Tab12SubEntryModel> subEntries =
              data.values.toList()[widget.entryIndex].reversed.toList();

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
                              Flexible(child: Text(entry.activity)),
                              Text(entry.importance.toString()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(entry.objective),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(child: Text("Assignment Period")),
                              Flexible(
                                child: Text(
                                  "${DateFormat(DateFormat.ABBR_MONTH_DAY).format(entry.tab2Model.startDate!)} - ${DateFormat(DateFormat.ABBR_MONTH_DAY).format(entry.tab2Model.endDate!)}",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(child: Text("Time Allocation")),
                              Flexible(
                                child: Text(
                                  "${entry.tab2Model.startTime.format(context)} - ${entry.tab2Model.getEndTime().format(context)} ",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(child: Text("Frequency")),
                              Flexible(
                                child: Text(
                                  entry.tab2Model.frequency!,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                      );
                    },
                    itemBuilder: (context, subEntryIndex) {
                      Tab12SubEntryModel subEntry = subEntries[subEntryIndex];
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
                            color: subEntryIndex != 0
                                ? Colors.indigo
                                : Colors.yellow[900],
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
                                          subEntry.nextTask,
                                        ),
                                      ),
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
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Next Task"),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
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
