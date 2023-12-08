import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';
import 'package:timely/modules/tab_3/views/input_screen.dart';
import 'package:timely/modules/tab_4/controllers/output_controller.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';
import 'package:timely/reusables.dart';

class Tab4OutputScreen extends ConsumerWidget {
  const Tab4OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab4OutputProvider);
    return provider.when(
      data: (data) {
        return Stack(
          children: [
            StatefulBuilder(
              builder: (context, setState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      // https://stackoverflow.com/questions/64135284/how-to-achieve-delete-and-undo-operations-on-dismissible-widget-in-flutter
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          return await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete"),
                                    content: const Text(
                                        'Are you sure you want to delete?'),
                                    actions: [
                                      IconButton.filledTonal(
                                          icon: const Icon(Icons.done),
                                          onPressed: () =>
                                              Navigator.pop(context, true)),
                                      IconButton.filled(
                                          icon: const Icon(Icons.dangerous),
                                          onPressed: () =>
                                              Navigator.pop(context, false)),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                        } else {
                          return false;
                        }
                      },
                      key: Key(data[index].uuid!),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          ref
                              .read(tab4RepositoryProvider.notifier)
                              .deleteModel(data[index]);
                          data.removeAt(index);
                          setState(() {});
                        }
                      },
                      child: InkWell(
                        onTap: () {
                          ref
                              .read(tab3InputProvider.notifier)
                              .setModel(data[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Scaffold(
                                  body: const Tab3InputScreen(),
                                  appBar: AppBar(),
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
                            ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 50),
                              child: Container(
                                color: Tab3OutputLayout
                                    .rowColors[data[index].priority],
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: Center(
                                        child: Text(
                                          (index + 1).toString(),
                                          style: Tab4OutputLayout.numberStyle,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data[index].text_1,
                                        style: Tab4OutputLayout.text_1Style,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
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
                                  body: const Tab3InputScreen(),
                                  appBar: AppBar(),
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
          ],
        );
      },
      error: (_, __) => const Text("ERROR"),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
