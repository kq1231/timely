import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_3/controllers/output_controller.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/views/input_screen.dart';
import 'package:timely/reusables.dart';

class Tab3OutputScreen extends ConsumerWidget {
  const Tab3OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab3OutputProvider);
    return provider.when(
        data: (data) {
          return Stack(children: [
            ListView(
              children: [
                ...List.generate(data.keys.toList().length, (index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(DateFormat("dd-MMM")
                            .format(DateTime.parse(data.keys.toList()[index]))),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            Tab3Model model =
                                data[data.keys.toList()[index]]![i];
                            // Row of time and text_1
                            return Container(
                              height: 50,
                              color: [
                                Colors.purple,
                                Colors.green,
                                Colors.pink
                              ][model.priority],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(model.time!.format(context)),
                                  Text(model.text_1),
                                ],
                              ),
                            );
                          },
                          itemCount: data[data.keys.toList()[index]]!.length,
                          shrinkWrap: true,
                        )
                      ],
                    ),
                  );
                })
              ],
            ),
            Column(
              children: [
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      child: Text(DateTime.now().toString().substring(5, 10)),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Tab3InputScreen();
                          },
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      child: const Icon(Icons.home),
                      onPressed: () =>
                          ref.read(tabIndexProvider.notifier).setIndex(12),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            )
          ]);
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const CircularProgressIndicator());
  }
}
