import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_8/controllers/input_controller.dart';
import 'package:timely/modules/tab_8/controllers/output_controller.dart';

class Tab8InputScreen extends ConsumerWidget {
  const Tab8InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab8InputProvider);
    final controller = ref.read(tab8InputProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text("LSJ"),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 120,
                      child: Container(
                        color: Colors.indigo[800],
                        child: CupertinoPicker(
                            selectionOverlay: Container(
                              color: const Color.fromARGB(78, 33, 149, 243),
                            ),
                            itemExtent: 60,
                            scrollController: FixedExtentScrollController(
                                initialItem: provider.lsj),
                            onSelectedItemChanged: (index) {
                              controller.setLSJ(index);
                            },
                            children: ["L", "S", "J"]
                                .map((label) => Center(child: Text(label)))
                                .toList()),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text("Priority"),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 120,
                      child: Container(
                        color: Colors.indigo[600],
                        child: CupertinoPicker(
                            selectionOverlay: Container(
                              color: const Color.fromARGB(78, 33, 149, 243),
                            ),
                            itemExtent: 60,
                            scrollController: FixedExtentScrollController(
                                initialItem: provider.hml),
                            onSelectedItemChanged: (index) {
                              controller.setHML(index);
                            },
                            children: ["High", "Medium", "Low"]
                                .map((label) => Center(child: Text(label)))
                                .toList()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 40,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: provider.title,
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
                  onChanged: (title) {
                    controller.setTitle(title);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: provider.title,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    filled: true,
                    hintText: "Description",
                  ),
                  onChanged: (description) {
                    controller.setDescription(description);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const Divider(
            height: 40,
          ),
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
                  ref.invalidate(tab8OutputProvider);
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
