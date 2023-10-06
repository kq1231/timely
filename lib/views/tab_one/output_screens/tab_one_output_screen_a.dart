import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one/output_screens/color_provider.dart';
import 'package:timely/controllers/tab_one/output_screens/output_screen_a_provider.dart';
import 'package:timely/layout_params.dart';

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
            itemBuilder: (context, index) {
              String date = data.keys.toList()[index];
              return Column(
                children: [
                  Text(
                    date,
                    style: timeStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (num ratingVal in data[date].values)
                          FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: colors[ratingVal.toInt()],
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
