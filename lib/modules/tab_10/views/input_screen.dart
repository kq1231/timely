import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_10/controllers/input_controller.dart';
import 'package:timely/modules/tab_10/controllers/output_controller.dart';

class Tab10InputScreen extends ConsumerWidget {
  const Tab10InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab10InputProvider);
    final controller = ref.read(tab10InputProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),

          // Date button
          SizedBox(
            width: 170,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                var dateSelected = await showDatePicker(
                    context: context,
                    initialDate: provider.date,
                    firstDate: DateTime(0),
                    lastDate: DateTime(
                      DateTime.now().year + 50,
                    ));
                if (dateSelected != null) {
                  controller.setDate(dateSelected);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                controller.getFormattedDate(),
              ),
            ),
          ),

          const Divider(
            height: 40,
          ),

          // Amount field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue:
                  provider.amount != 0.0 ? provider.amount.toString() : "",
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                filled: true,
                hintText: "Amount",
              ),
              onChanged: (amount) {
                controller.setAmount(amount);
              },
            ),
          ),

          const Divider(
            height: 40,
          ),

          // Text_1 field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: provider.text_1,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                filled: true,
                hintText: "Title",
              ),
              onChanged: (text_1) {
                controller.setText_1(text_1);
              },
            ),
          ),

          const Divider(
            height: 40,
          ),

          // Toggle buttons for options 1 and 2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Toggle"),
                ToggleButtons(
                  isSelected: List.generate(
                      2, (index) => (provider.option) == index + 1),
                  onPressed: (index) {
                    controller.setOption(index + 1);
                  },
                  children: const [Text("Op 1"), Text("Op 2")],
                ),
              ],
            ),
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
                  ref.invalidate(tab10OutputProvider);
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
