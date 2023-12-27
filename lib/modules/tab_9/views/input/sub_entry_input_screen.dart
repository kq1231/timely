import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/modules/tab_9/controllers/output/output_controller.dart';
import 'package:timely/modules/tab_9/views/input/molecules/sub_entry_input_molecule.dart';

class Tab9SubEntryInputScreen extends ConsumerWidget {
  final String entryUuid;

  const Tab9SubEntryInputScreen({super.key, required this.entryUuid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const Tab9SubEntryInputMolecule(),
        // Submit and cancel buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Cancel",
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Submit"),
              onPressed: () {
                ref
                    .read(tab9SubEntryInputProvider.notifier)
                    .syncToDB(entryUuid);
                ref.invalidate(tab9OutputProvider);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Submitted successfully..."),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
