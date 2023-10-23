import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/launch_screen/controllers/remaining_time_ticker.dart';
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
                child: Container(
                  color: launchSectionOneColor,
                  child: Center(
                    child: Text(
                      diff,
                      style: timeStyle.copyWith(
                          fontSize: 50, color: launchSectionOneTextColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: launchSectionTwoColor,
                  child: Center(
                    child: Text(
                      "Tab Two",
                      style:
                          timeStyle.copyWith(color: launchSectionTwoTextColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: launchSectionThreeColor,
                  child: Center(
                    child: Text(
                      "Tab Four",
                      style: timeStyle.copyWith(
                          color: launchSectionThreeTextColor),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
