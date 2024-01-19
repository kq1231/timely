import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/atomic/pages/input/tab_9_sub_entry_input_page.dart';
import 'package:timely/modules/tab_9/atomic/templates/output/tab_9_detail_template.dart';
import 'package:timely/modules/tab_9/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_9/models/entry_model.dart';
import 'package:timely/modules/tab_9/models/sub_entry_model.dart';

class Tab9DetailPage extends ConsumerStatefulWidget {
  final Tab9EntryModel entry;
  final List<Tab9SubEntryModel> subEntries;

  const Tab9DetailPage({
    super.key,
    required this.entry,
    required this.subEntries,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Tab9DetailPageState();
}

class _Tab9DetailPageState extends ConsumerState<Tab9DetailPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(tab9OutputProvider.notifier);

    return Tab9DetailTemplate(
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
        ref.invalidate(tab9SubEntryInputProvider);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(),
                body: Tab9SubEntryInputPage(entryID: entry.uuid!),
              );
            },
          ),
        );
      },
    );
  }
}
