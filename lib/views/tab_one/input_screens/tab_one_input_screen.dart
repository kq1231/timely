import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one/input_screen/input_controller.dart';

class TabOneInputScreen extends ConsumerWidget {
  const TabOneInputScreen({super.key});

  get child => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
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
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var time = ref.read(tabOneInputController).time_1;
                      TimeOfDay? time_1 = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                            hour: int.parse(time.split(":")[0]),
                            minute: int.parse(time.split(":")[1])),
                      );
                      if (time_1 != null) {
                        ref
                            .read(tabOneInputController.notifier)
                            .setTime_1("${time_1.hour}:${time_1.minute}");
                      }
                    },
                    child: const Row(
                      children: [
                        Text("Time 1"),
                        SizedBox(width: 10),
                        Icon(Icons.timer),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var time = ref.read(tabOneInputController).time_2;
                      TimeOfDay? time_2 = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                            hour: int.parse(time.split(":")[0]),
                            minute: int.parse(time.split(":")[1])),
                      );
                      if (time_2 != null) {
                        ref
                            .read(tabOneInputController.notifier)
                            .setTime_2("${time_2.hour}:${time_2.minute}");
                      }
                    },
                    child: const Row(
                      children: [
                        Text("Time 2"),
                        SizedBox(width: 10),
                        Icon(Icons.timer),
                      ],
                    ),
                  ),
                ],
              ),
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
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  StatefulBuilder(builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i in Iterable.generate(3))
                          Row(
                            children: [
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
                              Text(["Good", "Fair", "Poor"][i])
                            ],
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
                          text:
                              ref.read(tabOneInputController).types[0].comment),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  StatefulBuilder(builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i in Iterable.generate(3))
                          Row(
                            children: [
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
                              Text(["Good", "Fair", "Poor"][i])
                            ],
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
                          text:
                              ref.read(tabOneInputController).types[1].comment),
                      decoration:
                          const InputDecoration(label: Text("Text 2[B]")),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  StatefulBuilder(builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i in Iterable.generate(3))
                          Row(
                            children: [
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
                              Text(["Good", "Fair", "Poor"][i])
                            ],
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
                          text:
                              ref.read(tabOneInputController).types[2].comment),
                      decoration: const InputDecoration(
                        label: Text("Text 2[C]"),
                      ),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                      .syncChangesToDB(
                          DateTime.now().toString().substring(0, 10));
                  Navigator.pop(context);
                  ref.read(tabOneInputController.notifier).refreshProviders();
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
