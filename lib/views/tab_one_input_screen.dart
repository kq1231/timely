import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one_input_controller.dart';
import 'package:timely/layout_params.dart';

class TabOneInputScreen extends ConsumerWidget {
  const TabOneInputScreen({super.key});

  get child => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                DateTime.now().toString().substring(11, 16),
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
              ref.read(tabOneInputProvider.notifier).setText_1(value);
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
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 0,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeARatingValue();
                        setState(() {});
                      },
                    ),
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 1,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeBRatingValue();
                        setState(() {});
                      },
                    ),
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 2,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeCRatingValue();
                        setState(() {});
                      },
                    ),
                  ],
                );
              }),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Text 2[A]")),
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
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 0,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeARatingValue();
                        setState(() {});
                      },
                    ),
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 1,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeBRatingValue();
                        setState(() {});
                      },
                    ),
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 2,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeCRatingValue();
                        setState(() {});
                      },
                    ),
                  ],
                );
              }),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Text 2[A]")),
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
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 0,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeARatingValue();
                        setState(() {});
                      },
                    ),
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 1,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeBRatingValue();
                        setState(() {});
                      },
                    ),
                    Radio(
                      value: ref.read(tabOneInputProvider)[0].ratingValue,
                      groupValue: 2,
                      onChanged: (value) {
                        ref
                            .read(tabOneInputProvider.notifier)
                            .activateTypeCRatingValue();
                        setState(() {});
                      },
                    ),
                  ],
                );
              }),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(label: Text("Text 2[A]")),
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
                DateTime.now().toString().substring(11, 16),
                style: timeStyle,
              ),
              const Spacer(
                flex: 5,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
              const Spacer(
                flex: 1,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Submit")),
            ],
          ),
        ),
      ],
    );
  }
}
