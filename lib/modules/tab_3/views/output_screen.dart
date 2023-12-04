import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';
import 'package:timely/modules/tab_3/controllers/output_controller.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/tab_3_repo.dart';
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
            StatefulBuilder(
              builder: (context, setState) {
                return ListView(
                  children: [
                    ...List.generate(data.keys.toList().length, (index) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          Tab3Model model = data[data.keys.toList()[index]]![i];
                          // Row of time and text_1
                          return Dismissible(
                            background: Container(color: Colors.red),
                            onDismissed: (direction) {
                              ref
                                  .read(tab3RepositoryProvider.notifier)
                                  .deleteModel(model);
                              data[data.keys.toList()[index]]!.removeAt(i);
                              setState(() {});
                            },
                            key: Key(model.uuid!),
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(tab3InputProvider.notifier)
                                    .setModel(model);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Scaffold(
                                        appBar: AppBar(),
                                        body: const Tab3InputScreen(),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  const Divider(
                                    height: 2,
                                  ),
                                  Container(
                                    height: 50,
                                    color: Tab3OutputLayout
                                        .rowColors[model.priority],
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: Center(
                                            child: Text(
                                              DateFormat("dd-MMM").format(
                                                  DateTime.parse(data.keys
                                                      .toList()[index])),
                                              style: Tab3OutputLayout.dateStyle,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Center(
                                            child: Text(
                                              model.time!.format(context),
                                              style: Tab3OutputLayout.timeStyle,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          model.text_1,
                                          style: Tab3OutputLayout.text_1Style,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: data[data.keys.toList()[index]]!.length,
                        shrinkWrap: true,
                      );
                    })
                  ],
                );
              },
            ),
            Column(
              children: [
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      child: const Icon(Icons.home),
                      onPressed: () =>
                          ref.read(tabIndexProvider.notifier).setIndex(12),
                    ),
                    FloatingActionButton(
                        heroTag: null,
                        child: const Icon(Icons
                            .add), // Text(DateTime.now().toString().substring(5, 10)),
                        onPressed: () {
                          ref.invalidate(tab3InputProvider);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(),
                                  body: const Tab3InputScreen(),
                                );
                              },
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            )
          ]);
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
