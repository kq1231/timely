import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one/input_controller.dart';
import 'package:timely/controllers/time_provider.dart';
import 'package:timely/layout_params.dart';

class TabOneInputScreen extends ConsumerWidget {
  const TabOneInputScreen({super.key});

  get child => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(tabOneInputController.notifier)
        .setTime_1(ref.read(timeProvider)["time_1"]);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                DateTime.now().toString().substring(0, 10),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                ref.read(timeProvider)["time_1"],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: TextEditingController(text: ref.read(text_1Provider)),
            decoration: const InputDecoration(labelText: "Text 1"),
            onChanged: (value) {
              ref.read(text_1Provider.notifier).state = value;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  children: [
                    for (int i in Iterable.generate(3))
                      Radio(
                        value: ref
                            .read(tabOneInputController)
                            .types[0]
                            .rating
                            .indexOf(1),
                        groupValue: i,
                        onChanged: (value) {
                          ref
                              .read(tabOneInputController.notifier)
                              .setTypeARating(i);
                          setState(() {});
                        },
                      ),
                  ],
                );
              }),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: ref.read(tabOneInputController).types[0].comment),
                  decoration: const InputDecoration(
                    label: Text("Text 2[A]"),
                  ),
                  onChanged: (value) {
                    ref
                        .read(tabOneInputController.notifier)
                        .setTypeAComment(value);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  children: [
                    for (int i in Iterable.generate(3))
                      Radio(
                        value: ref
                            .read(tabOneInputController)
                            .types[1]
                            .rating
                            .indexOf(1),
                        groupValue: i,
                        onChanged: (value) {
                          ref
                              .read(tabOneInputController.notifier)
                              .setTypeBRating(i);
                          setState(() {});
                        },
                      ),
                  ],
                );
              }),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: ref.read(tabOneInputController).types[1].comment),
                  decoration: const InputDecoration(label: Text("Text 2[B]")),
                  onChanged: (value) {
                    ref
                        .read(tabOneInputController.notifier)
                        .setTypeBComment(value);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  children: [
                    for (int i in Iterable.generate(3))
                      Radio(
                        value: ref
                            .read(tabOneInputController)
                            .types[2]
                            .rating
                            .indexOf(1),
                        groupValue: i,
                        onChanged: (value) {
                          ref
                              .read(tabOneInputController.notifier)
                              .setTypeCRating(i);
                          setState(() {});
                        },
                      ),
                  ],
                );
              }),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: ref.read(tabOneInputController).types[2].comment),
                  decoration: const InputDecoration(label: Text("Text 2[C]")),
                  onChanged: (value) {
                    ref
                        .read(tabOneInputController.notifier)
                        .setTypeCComment(value);
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ref.read(timeProvider)["time_2"],
                style: timeStyle,
              ),
              const Spacer(
                flex: 5,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(tabOneInputController.notifier)
                      .syncChangesToDB();
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
