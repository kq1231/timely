import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';

class Tab12SubEntryInputMolecule extends ConsumerWidget {
  const Tab12SubEntryInputMolecule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab12SubEntryInputProvider);
    final controller = ref.read(tab12SubEntryInputProvider.notifier);

    return Column(
      children: [
        // Next Task TextField
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.nextTask,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Next Task",
            ),
            onChanged: (name) {
              controller.setName(name);
            },
          ),
        ),
        const Divider(
          height: 40,
        ),
      ],
    );
  }
}
