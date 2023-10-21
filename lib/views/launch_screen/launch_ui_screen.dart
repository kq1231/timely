import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/controllers/launch_screen/remaining_time_ticker.dart';
import 'package:timely/layout_params.dart';

class LaunchScreen extends ConsumerWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var remTime = ref.watch(remainingTimeTickerProvider);
    return remTime.when(
        data: (diff) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    diff,
                    style: timeStyle.copyWith(fontSize: 50),
                  ),
                ),
              ),
              const Expanded(
                child: Text("Tab Two"),
              ),
              const Expanded(
                child: Text("Tab Four"),
              ),
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
