import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one/intervals_provider.dart';
import 'package:timely/layout_params.dart';

class TabOneOutputScreenB extends ConsumerWidget {
  const TabOneOutputScreenB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intervalsFutureProvider = ref.watch(tabOneIntervalsProvider);

    return intervalsFutureProvider.when(
      data: (intervals) {
        return ListView(
          children: [
            for (var interval in intervals)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "${interval.date}  ${interval.time_1}",
                          style: timeStyle,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              for (var type in interval.types)
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        type.comment,
                                        style: timeStyle,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        );
      },
      error: (_, __) => const Text("ERROR"),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
