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
            return Container(
              decoration: BoxDecoration(
                color: outputScreenBAlternatingTileColors[index % 2],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "${interval.date} | ${interval.time_1} | ${interval.types.map((type) => type.comment).join(", ")}",
                      style: tabOneOutputScreenBCommentStyle.copyWith(
                        color: outputScreenBCommentTextColors[index % 2],
                      ),
                    ),
                  ],
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
