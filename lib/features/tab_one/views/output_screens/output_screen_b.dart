import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_one/controllers/intervals_provider.dart';
import 'package:timely/layout_params.dart';

class TabOneOutputScreenB extends ConsumerWidget {
  const TabOneOutputScreenB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intervalsFutureProvider = ref.watch(tabOneIntervalsProvider);

    return intervalsFutureProvider.when(
      data: (intervals) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: intervals.length,
          itemBuilder: (context, index) {
            var interval = intervals[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: outputScreenBAlternatingTileColors[index % 2],
                  border: Border.all(color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(
                          "${interval.date}  ${interval.time_1}",
                          style: h3TextStyle.copyWith(
                              color: outputScreenBCommentTextColors[index % 2]),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        interval.types
                                            .map((type) => type.comment)
                                            .join(", "),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: outputScreenBCommentTextColors[
                                              index % 2],
                                        ),
                                      ),
                                    ),
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
            );
          },
        );
      },
      error: (_, __) => const Text("ERROR"),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
