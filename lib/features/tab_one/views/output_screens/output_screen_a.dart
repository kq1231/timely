import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/public_providers/color_provider.dart';
import 'package:timely/features/tab_one/controllers/output_screens/output_screen_a_provider.dart';
import 'package:timely/layout_params.dart';
import 'package:timely/features/tab_one/models/color_rater.dart';

class TabOneOutputScreenA extends ConsumerWidget {
  const TabOneOutputScreenA({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outputScreenAFutureProvider = ref.watch(outputScreenAProvider);
    final colors = ref.read(colorProvider);
    return outputScreenAFutureProvider.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String date = data.keys.toList()[index];
              return Column(
                children: [
                  Text(
                    date,
                    style: tabOneOutputScreenADateStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        for (ColorRater colorRating in data[date]!)
                          FloatingActionButton(
                            heroTag: null,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        for (String text_2
                                            in colorRating.text_2s)
                                          Center(
                                            child: Text(
                                              text_2,
                                              style:
                                                  tabOneOutputScreenADateStyle,
                                            ),
                                          )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            backgroundColor:
                                colors[colorRating.ratingResult.toInt()],
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  colorRating.time_1,
                                  style: tabOneOutputScreenATimeStyle,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              );
            },
            itemCount: data.keys.toList().length,
          ),
        );
      },
      error: (_, __) => const Text("Error"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
