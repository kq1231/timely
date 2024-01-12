import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_12/controllers/archived/archived_provider.dart';
import 'package:timely/modules/tab_12/controllers/input/entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';
import 'package:timely/modules/tab_12/views/archived/detail_screen.dart';
import 'package:timely/modules/tab_12/views/input/entry_input_screen.dart';
import 'package:timely/reusables.dart';

class Tab12ArchiveSummaryScreen extends ConsumerStatefulWidget {
  const Tab12ArchiveSummaryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab12OutputScreenState();
}

class _Tab12OutputScreenState extends ConsumerState<Tab12ArchiveSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab12ArchivedProvider);

    return Stack(
      children: [
        provider.when(
          data: (data) {
            List<Tab12EntryModel> entries = data.keys.toList();
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                  thickness: 2,
                  color: Colors.black,
                );
              },
              itemBuilder: (context, entryIndex) {
                Tab12EntryModel entry = entries[entryIndex];
                List<Tab12SubEntryModel> subEntries =
                    data.values.toList()[entryIndex];
                Tab12SubEntryModel lastSubEntry = subEntries.last;

                return Ink(
                  color: entryIndex % 2 == 0
                      ? Colors.indigo[400]
                      : Colors.indigo[800],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  entry.activity,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              child: Text(
                                entry.importance.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                                    .format(entry.tab2Model
                                        .getNextOccurenceDateTime())),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(),
                                  body: Tab12ArchiveDetailScreen(
                                    entryIndex: entryIndex,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      lastSubEntry.nextTask,
                                    ),
                                  ),
                                ),
                              ],
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
                    ref.invalidate(tab12EntryInputProvider);
                    ref.invalidate(tab12SubEntryInputProvider);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(),
                            body: const Tab12EntryInputScreen(
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
