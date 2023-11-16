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
                      data["tab_1Text"],
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
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      List models = data["tab_3"];

                      return Column(
                        children: [
                          const Divider(
                            height: 1,
                          ),
                          const Divider(
                            height: 1,
                          ),
                          ...List.generate(models.length, (i) {
                            return Container(
                              color: [
                                Colors.purple,
                                Colors.green,
                                Colors.pink
                              ][models[i].priority],
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: Center(
                                      child: Text(
                                          models[i].time.format(context),
                                          style: timelyStyle),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      models[i].text_1,
                                      style: timelyStyle,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        ],
                      );
                    },
                    itemCount: data["tab_3"].length,
                  ),
                ),
              ),
              const Divider(
                height: 2,
              ),
              // Output4
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
                              child: Container(
                                color: [
                                  Colors.purple,
                                  Colors.green,
                                  Colors.pink
                                ][data["tab_4"][index][0]],
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
                                        data["tab_4"][index][1],
                                        style: timelyStyle.copyWith(
                                          color: launchSectionThreeTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            index != data["tab_4"].length - 1
                                ? Divider(
                                    color: Colors.grey[900],
                                    height: 1,
                                  )
                                : Container(),
                          ],
                        );
                      },
                      itemCount: data["tab_4"].length,
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
