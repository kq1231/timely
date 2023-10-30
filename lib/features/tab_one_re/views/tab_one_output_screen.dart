import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_one_re/controllers/output_controller.dart';
import 'package:timely/features/tab_one_re/views/tab_one_input_screen.dart';
import 'package:timely/layout_params.dart';
import 'package:timely/public_providers.dart/tab_index_provider.dart';

class TabOneOutputScreen extends ConsumerWidget {
  const TabOneOutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tabOneFutureProvider);
    return provider.when(
        data: (data) {
          return Stack(
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        color: Colors.grey[800],
                        child: Column(
                          children: [
                            Text(data[index].date, style: timelyStyle),
                            Text(
                                "${data[index].nextUpdateTime.hour}:${data[index].nextUpdateTime.minute}")
                          ],
                        ),
                      ),
                      ...List.generate(
                        3,
                        ((i) {
                          List names = "F,M,S".split(",");
                          List scores = [
                            data[index].fScore,
                            data[index].mScore,
                            data[index].sScore
                          ];
                          return SizedBox(
                            width: 50,
                            child: Container(
                              color: Colors.orange[800],
                              child: Column(
                                children: [
                                  Text(scores[i].toString()),
                                  Text(names[i]),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      Flexible(child: Text(data[index].text_1)),
                    ],
                  );
                },
                itemCount: data.length,
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
                          child: Text(
                              "${DateTime.now().day}-${DateTime.now().month}"),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Scaffold(
                                appBar: AppBar(),
                                body: const TabOneInputScreen(),
                              );
                            }));
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
