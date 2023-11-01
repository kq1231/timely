import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/home_module/launch_screen/controllers/remaining_time_ticker.dart';
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
              const Divider(
                height: 2,
              ),
              SizedBox(
                height: 50,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      color: launchSectionOneTimerColor,
                      child: Center(
                        child: Text(
                          diff,
                          style: timelyStyle.copyWith(
                              fontSize: 15,
                              color: launchSectionOneTimerTextColor),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    width: 2,
                  ),
                  Expanded(
                    child: Container(
                      color: launchSectionOneAlertColor,
                      child: Center(
                        child: Text(
                          "Alert",
                          style: timelyStyle.copyWith(
                              fontSize: 15,
                              color: launchSectionOneAlertTextColor),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              const Divider(
                height: 2,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: launchSectionTwoColor,
                  child: Center(
                    child: Text(
                      "First Tab's Text One",
                      style: timelyStyle.copyWith(
                          color: launchSectionTwoTextColor),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: launchSectionThreeColor,
                  child: Center(
                    child: Text(
                      "Third Tab's Data",
                      style: timelyStyle.copyWith(
                          color: launchSectionThreeTextColor),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: launchSectionFourColor,
                  child: Center(
                    child: Text(
                      "Fourth Tab's Data",
                      style: timelyStyle.copyWith(
                        color: launchSectionThreeTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
            ],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
