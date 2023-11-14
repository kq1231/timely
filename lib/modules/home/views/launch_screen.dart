import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/home/controllers/tabs_data_provider.dart';

class LaunchScreen extends ConsumerWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabsData = ref.watch(tabsDataProvider);
    return tabsData.when(
        data: (data) {
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
                        child: Consumer(
                          builder: (context, ref, child) {
                            var remTime =
                                ref.watch(remainingTimeTickerProvider);

                            return remTime.when(
                                data: (diff) {
                                  return Text(
                                    diff,
                                    style: timelyStyle.copyWith(
                                        fontSize: 15,
                                        color: launchSectionOneTimerTextColor),
                                  );
                                },
                                error: (_, __) => const Text("ERROR"),
                                loading: () => const CircularProgressIndicator(
                                      color: Colors.black,
                                    ));
                          },
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
                      data[0],
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
                      data[1],
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
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: timelyStyle.copyWith(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      data[2][index],
                                      style: timelyStyle.copyWith(
                                        color: launchSectionThreeTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            index != data[2].length - 1
                                ? const Divider(color: Colors.black)
                                : Container(),
                          ],
                        );
                      },
                      itemCount: data[2].length,
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
