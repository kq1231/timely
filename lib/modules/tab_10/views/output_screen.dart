import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_10/controllers/input_controller.dart';
import 'package:timely/modules/tab_10/controllers/output_controller.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/modules/tab_10/repositories/completed_repo.dart';
import 'package:timely/modules/tab_10/repositories/pending_repo.dart';
import 'package:timely/modules/tab_10/views/input_screen.dart';
import 'package:timely/reusables.dart';

class Tab10OutputScreen extends ConsumerStatefulWidget {
  const Tab10OutputScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab10OutputScreenState();
}

class _Tab10OutputScreenState extends ConsumerState<Tab10OutputScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab10OutputProvider);
    return Stack(children: [
      provider.when(
        data: (models) {
          return ListView.separated(
            itemBuilder: (context, index) {
              Tab10Model model = models[index];
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
                    return false;
                  }
                },
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    ref
                        .read(tab10PendingRepositoryProvider.notifier)
                        .deleteModel(model);
                    models.removeWhere((element) => element.uuid == model.uuid);
                    setState(() {});
                  }
                },
                key: Key(model.uuid!),
                child: InkWell(
                  onTap: () {
                    ref.read(tab10InputProvider.notifier).setModel(model);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(),
                          body: const Tab10InputScreen(),
                        );
                      },
                    ));
                  },
                  child: Container(
                    color: model.option == 1 ? Colors.green : Colors.red[600],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat(DateFormat.ABBR_MONTH_DAY)
                                .format(model.date),
                          ),
                          Text(model.amount.toString()),
                          Flexible(child: Text(model.text_1)),
                          StatefulBuilder(
                            builder: (context, setCheckboxState) {
                              return Checkbox(
                                  value: model.isComplete,
                                  onChanged: (value) async {
                                    model.isComplete = true;
                                    setCheckboxState(() {});
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));

                                    // Shift the model from pending DB to completed DB and refresh immediately
                                    // after model is removed from pending DB.
                                    await ref
                                        .read(tab10PendingRepositoryProvider
                                            .notifier)
                                        .deleteModel(model);
                                    models.removeWhere(
                                        (e) => e.uuid == model.uuid);
                                    setState(() {});
                                    await ref
                                        .read(tab10CompletedRepositoryProvider
                                            .notifier)
                                        .writeTab10ModelAsComplete(model);
                                  });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: models.length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 4,
              );
            },
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
                    ref.invalidate(tab10InputProvider);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: const Tab10InputScreen(),
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
