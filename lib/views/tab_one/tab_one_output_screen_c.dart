import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/tab_one/output_screen_c_provider.dart';
import 'package:timely/layout_params.dart';

class TabOneOutputScreenC extends ConsumerWidget {
  const TabOneOutputScreenC({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("BUILD");
    AsyncValue text_1sFutureProvider = ref.watch(outputScreenCProvider);

    Future.delayed(const Duration(seconds: 6), () {
      return ref.invalidate(outputScreenCProvider);
    });

    return text_1sFutureProvider.when(
        data: (tab_1s) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tab_1s.keys.toList()[index], style: timeStyle),
                    Text(
                      tab_1s.values.toList()[index],
                      style: timeStyle,
                    ),
                  ],
                ),
              );
            },
            itemCount: tab_1s.keys.toList().length,
          );
        },
        error: (_, __) => const Center(child: Text("Error")),
        loading: () => const CircularProgressIndicator());
  }
}
