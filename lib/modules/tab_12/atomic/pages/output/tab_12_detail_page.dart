import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_12/atomic/pages/input/tab_12_sub_entry_input_page.dart';
import 'package:timely/modules/tab_12/atomic/templates/output/tab_12_detail_template.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_12/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_12/models/entry_model.dart';
import 'package:timely/modules/tab_12/models/sub_entry_model.dart';

class Tab12DetailPage extends ConsumerStatefulWidget {
  final Tab12EntryModel entry;
  final List<Tab12SubEntryModel> subEntries;

  const Tab12DetailPage({
    super.key,
    required this.entry,
    required this.subEntries,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab12DetailPageState();
}

class _Tab12DetailPageState extends ConsumerState<Tab12DetailPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(tab12OutputProvider.notifier);

    return Tab12DetailTemplate(
      onTapSubEntry: (entry, subEntry) async {
        ref.read(tab12SubEntryInputProvider.notifier).setModel(subEntry);

        await Future.delayed(
          const Duration(milliseconds: 100),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(),
                    body: Tab12SubEntryInputPage(
                      entryID: entry.uuid!,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      entry: widget.entry,
      subEntries: widget.subEntries,
      onSubEntryDismissed: (direction, entry, subEntry) {
        if (direction == DismissDirection.startToEnd) {
          widget.subEntries.removeWhere((v) => v.uuid == subEntry.uuid);
          controller.deleteSubEntry(entry.uuid!, subEntry);
          setState(() {});
        } else {
          widget.subEntries.removeWhere((v) => v.uuid == subEntry.uuid);
          setState(() {});

          controller.markSubEntryAsComplete(entry, subEntry);
        }
      },
      onPressedAdd: (entry) {
        ref.invalidate(tab12SubEntryInputProvider);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(),
                body: Tab12SubEntryInputPage(entryID: entry.uuid!),
              );
            },
          ),
        );
      },
    );
  }
}
