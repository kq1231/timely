import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/controllers/output_controller.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
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
              ListView.builder(
                itemBuilder: (context, i) {
                  Tab2Model model = models[i];
                  return SizedBox(
                    height: 40,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        border: Border.symmetric(
                          horizontal:
                              BorderSide(width: 0.7, color: Colors.black),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    model.name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                model.startTime.format(context),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                model.calculateEndTime(model.endTime).join(":"),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
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
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Scaffold(
                                appBar: AppBar(),
                                body: const Tab2InputScreen(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              )
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const CircularProgressIndicator());
  }
}
