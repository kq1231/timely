import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one/tab_one_output_screen_c_provider.dart';
import 'package:timely/layout_params.dart';

class TabOneOutputScreenC extends ConsumerWidget {
  const TabOneOutputScreenC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabOneOutputC = ref.watch(tabOneOutputScreenCProvider);

    return tabOneOutputC.maybeWhen(data: (data) {
      return ListView(
        children: [
          for (String date in data.keys)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: timeStyle,
                  ),
                  for (int i in Iterable.generate(1))
                    Text(data[date]["type_${["a", "b", "c"][i]}"])
                ],
              ),
            ),
        ],
      );
    }, orElse: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
