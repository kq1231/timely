import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_11/controllers/input_controller.dart';

class Tab11InputScreen extends ConsumerWidget {
  const Tab11InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab11InputProvider);
    final controller = ref.read(tab11InputProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),

          // Item field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: provider.item,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                filled: true,
                hintText: "Item",
              ),
              onChanged: (item) {
                controller.setItem(item);
              },
            ),
          ),
          const Divider(
            height: 40,
          ),

          // Quantity field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              initialValue: provider.qty != 0 ? provider.qty.toString() : "",
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                filled: true,
                hintText: "Quantity",
              ),
              onChanged: (qty) {
                controller.setQuantity(qty);
              },
            ),
          ),

          const Divider(
            height: 40,
          ),

          // Unit Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Unit"),
              DropdownMenu(
                initialSelection: provider.unit,
                dropdownMenuEntries: [
                  for (String unit in ["KG", "Mg", "G", "Lit", "mLit"])
                    DropdownMenuEntry(value: unit, label: unit)
                ],
                onSelected: (unit) {
                  if (unit != null) {
                    controller.setUnit(unit);
                  }
                },
              ),
            ],
          ),

          const Divider(
            height: 40,
          ),

          // Urgency Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Urgent"),
              Switch(
                  value: provider.urgent,
                  onChanged: (value) {
                    controller.setUrgency(value);
                  }),
            ],
          ),

          const SizedBox(
            height: 40,
          ),

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
                  controller.syncToDB();
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
            height: 20,
          ),
        ],
      ),
    );
  }
}
