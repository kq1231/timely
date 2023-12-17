import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_11/controllers/input_controller.dart';
import 'package:timely/modules/tab_11/controllers/output_controller.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';
import 'package:timely/modules/tab_11/views/input_screen.dart';
import 'package:timely/reusables.dart';

class Tab11OutputScreen extends ConsumerStatefulWidget {
  const Tab11OutputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab11OutputScreenState();
}

class _Tab11OutputScreenState extends ConsumerState<Tab11OutputScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab11OutputProvider);
    final controller = ref.read(tab11OutputProvider.notifier);

    return Stack(children: [
      provider.when(
        data: (models) {
          return Column(
            children: [
              Container(
                color: Colors.indigo,
                height: 50,
                child: const Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Center(child: Text("Item")),
                    )),
                    SizedBox(width: 60, child: Center(child: Text("Quantity"))),
                    SizedBox(width: 60, child: Center(child: Text("Unit"))),
                    SizedBox(width: 60, child: Center(child: Text("Urgent?"))),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Tab11Model model = models[index];
                  return Dismissible(
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
                        return await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Mark Complete"),
                                  content: const Text(
                                      'Are you sure you want to mark as completed?'),
                                  actions: [
                                    IconButton.filledTonal(
                                      icon: const Icon(Icons.done),
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                    ),
                                    IconButton.filled(
                                      icon: const Icon(Icons.dangerous),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                      }
                    },
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        controller.deleteModel(model);

                        models.removeWhere(
                            (element) => element.uuid == model.uuid);
                        setState(() {});
                      } else {
                        models.removeWhere((e) => e.uuid == model.uuid);
                        setState(() {});

                        controller.markModelAsComplete(model);
                      }
                    },
                    key: Key(model.uuid!),
                    child: InkWell(
                      onTap: () {
                        ref.read(tab11InputProvider.notifier).setModel(model);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Scaffold(
                              appBar: AppBar(),
                              body: const Tab11InputScreen(),
                            );
                          },
                        ));
                      },
                      child: Container(
                        color: Colors.indigo[400],
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(child: Center(child: Text(model.item))),
                            SizedBox(
                              width: 60,
                              child: Center(child: Text(model.qty.toString())),
                            ),
                            SizedBox(
                              width: 60,
                              child: Center(child: Text(model.unit)),
                            ),
                            SizedBox(
                              width: 60,
                              child: Center(
                                  child: Text(
                                      model.urgent == true ? "Yes" : "No")),
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: models.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 2,
                  );
                },
              ),
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.home),
                  onPressed: () {
                    ref.read(tabIndexProvider.notifier).setIndex(12);
                  }),
              FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    ref.invalidate(tab11InputProvider);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: const Tab11InputScreen(),
                      );
                    }));
                  }),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      )
    ]);
  }
}
