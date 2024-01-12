import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_12/controllers/archived/archived_provider.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';

class Tab12ArchiveDetailScreen extends ConsumerStatefulWidget {
  final int entryIndex;

  const Tab12ArchiveDetailScreen({super.key, required this.entryIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab12DetailScreenState();
}

class _Tab12DetailScreenState extends ConsumerState<Tab12ArchiveDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab12ArchivedProvider);

    return provider.when(
        data: (data) {
          Tab12EntryModel entry = data.keys.toList()[widget.entryIndex];
          List<Tab12SubEntryModel> subEntries =
              data.values.toList()[widget.entryIndex].reversed.toList();

          return ListView(
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
                  return Container(
                    color:
                        subEntryIndex != 0 ? Colors.indigo : Colors.yellow[900],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  );
                },
                itemCount: subEntries.length,
              )
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const CircularProgressIndicator());
  }
}
