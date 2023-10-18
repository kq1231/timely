import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one/output_screens/output_screen_c_provider.dart';
import 'package:timely/layout_params.dart';

class TabOneOutputScreenC extends ConsumerWidget {
  const TabOneOutputScreenC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue text_1sFutureProvider = ref.watch(outputScreenCProvider);

    return text_1sFutureProvider.when(
        data: (tab_1s) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(tab_1s.keys.toList()[index], style: timeStyle),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        tab_1s.values.toList()[index],
                        style: timeStyle,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: tab_1s.keys.toList().length,
          );
        },
        error: (_, __) => const Center(child: Text("Error")),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
