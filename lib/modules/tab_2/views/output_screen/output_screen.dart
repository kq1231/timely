import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_2/controllers/input_controller.dart';
import 'package:timely/modules/tab_2/controllers/output_controller.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/modules/tab_2/repositories/tab_2_repo.dart';
import 'package:timely/modules/tab_2/views/input_screen/input_screen.dart';
import 'package:timely/reusables.dart';

class Tab2OutputScreen extends ConsumerWidget {
  const Tab2OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab2OutputProvider);

    return provider.when(
        data: (data) {
          List<Tab2Model> models = data;
          return Stack(
            children: [
              StatefulBuilder(builder: ((context, setState) {
                return ListView(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                                color: Colors.indigo[300],
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: Text("Activities")),
                                )),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.indigo[400],
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text("Start")),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                color: Colors.indigo[500],
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(child: Text("End")),
                                )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    ...List.generate(
                      data.length,
                      (i) {
                        Tab2Model model = models[i];
                        List<int> endTime = model.calculateEndTime(model.dur);
                        return Dismissible(
                          background: Container(color: Colors.red),
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
                                              onPressed: () => Navigator.pop(
                                                  context, false)),
                                        ],
                                      );
                                    },
                                  ) ??
                                  false;
                            } else {
                              return false;
                            }
                          },
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              ref
                                  .read(tab2RepositoryProvider.notifier)
                                  .deleteModel(model);
                              data.removeAt(i);
                              setState(() {});
                            }
                          },
                          key: Key(model
                              .uuid!), // ! is used when you are sure that the nullable field will never be null
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 60),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.indigo[700],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    ref
                                        .read(tab2InputProvider.notifier)
                                        .setModel(model);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Scaffold(
                                            body: const Tab2InputScreen(),
                                            appBar: AppBar(),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Text(
                                            model.name,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            DateFormat("h:mm a").format(
                                              DateTime(
                                                  0,
                                                  0,
                                                  0,
                                                  model.startTime.hour,
                                                  model.startTime.minute),
                                            ),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            DateFormat("h:mm a").format(
                                              DateTime(0, 0, 0, endTime[0],
                                                  endTime[1]),
                                            ),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              })),
              Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingActionButton(
                        heroTag: null,
                        child: const Icon(Icons.home),
                        onPressed: () {
                          ref.read(tabIndexProvider.notifier).setIndex(12);
                        },
                      ),
                      FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons
                              .add), // Text(DateTime.now().toString().substring(5, 10)),
                          onPressed: () {
                            ref.invalidate(tab2InputProvider);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(),
                                    body: const Tab2InputScreen(),
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
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
