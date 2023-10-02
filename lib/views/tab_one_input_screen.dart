import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one_input_controllers.dart';
import 'package:timely/controllers/time_provider.dart';
import 'package:timely/layout_params.dart';

class TabOneInputScreen extends ConsumerWidget {
  const TabOneInputScreen({super.key});

  get child => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(tabOneInputSubTypesProvider.notifier)
      ..setTime_1(ref.read(timeProvider)["time_1"])
      ..setTime_2(ref.read(timeProvider)["time_2"]);

    final savingState = ref.watch(tabOneSyncInputProvider);

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
            decoration: const InputDecoration(labelText: "Text 1"),
            onChanged: (value) {
              ref.read(tabOneInputSubTypesProvider.notifier).setText_1(value);
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
                            .read(tabOneInputSubTypesProvider)[0]
                            .ratingValue,
                        groupValue: i,
                        onChanged: (value) {
                          ref
                              .read(tabOneInputSubTypesProvider.notifier)
                              .activateTypeARatingValue(i);
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
                  decoration: const InputDecoration(label: Text("Text 2[A]")),
                  onChanged: (value) {
                    ref
                        .read(tabOneInputSubTypesProvider.notifier)
                        .setTypeAText_2(value);
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
                            .read(tabOneInputSubTypesProvider)[1]
                            .ratingValue,
                        groupValue: i,
                        onChanged: (value) {
                          ref
                              .read(tabOneInputSubTypesProvider.notifier)
                              .activateTypeBRatingValue(i);
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
                  decoration: const InputDecoration(label: Text("Text 2[B]")),
                  onChanged: (value) {
                    ref
                        .read(tabOneInputSubTypesProvider.notifier)
                        .setTypeBText_2(value);
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
                            .read(tabOneInputSubTypesProvider)[2]
                            .ratingValue,
                        groupValue: i,
                        onChanged: (value) {
                          ref
                              .read(tabOneInputSubTypesProvider.notifier)
                              .activateTypeCRatingValue(i);
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
                  decoration: const InputDecoration(label: Text("Text 2[C]")),
                  onChanged: (value) {
                    ref
                        .read(tabOneInputSubTypesProvider.notifier)
                        .setTypeCText_2(value);
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
                    await ref.read(tabOneSyncInputProvider.notifier).syncToDB();
                  },
                  child: savingState is AsyncLoading<void>
                      ? CircularProgressIndicator()
                      : Text("Submit")),
            ],
          ),
        ),
      ],
    );
  }
}
