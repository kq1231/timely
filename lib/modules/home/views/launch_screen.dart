import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/home/controllers/tabs_data_provider.dart';
import 'package:timely/modules/home/views/tab_buttons.dart';
import 'package:timely/modules/tab_1/atomic/pages/fms_page.dart';

class LaunchScreen extends ConsumerWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabsData = ref.watch(tabsDataProvider);
    return Row(
      children: [
        const TabButtons(),
        const VerticalDivider(
          width: 2,
          thickness: 2,
        ),
        Expanded(
          child: tabsData.when(
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
                                        style: LaunchScreenLayout.timeStyle,
                                      );
                                    },
                                    error: (_, __) => const Text("ERROR"),
                                    loading: () =>
                                        const CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  );
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
                                style: LaunchScreenLayout.alertStyle,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    const Divider(
                      height: 2,
                    ),
                    const Expanded(
                      flex: 4,
                      child: FMSPage(),
                    ),
                    const Divider(
                      height: 0.2,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: launchSectionThreeColor,
                        child: data["tab_3"].length == 0
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(child: Text("Default Text 2")),
                                ],
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  List models = data["tab_3"];

                                  return Column(
                                    children: [
                                      const Divider(
                                        height: 0.2,
                                      ),
                                      Container(
                                        color: LaunchScreenLayout
                                            .colors[models[index].priority],
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minHeight: 50),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    models[index].text_1,
                                                    style: LaunchScreenLayout
                                                        .tab3TextStyle,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 70,
                                                child: Center(
                                                  child: Text(
                                                      models[index]
                                                          .time
                                                          .format(context),
                                                      style: LaunchScreenLayout
                                                          .tab3TextStyle),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: data["tab_3"].length,
                              ),
                      ),
                    ),
                    const Divider(
                      height: 0.2,
                    ),
                    // Output4
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: launchSectionFourColor,
                        child: data["tab_4"].length == 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(child: Text("Default Text 3")),
                                ],
                              )
                            : Center(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minHeight: 50),
                                          child: Container(
                                            color: LaunchScreenLayout.colors[
                                                data["tab_4"][index][0]],
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 30,
                                                  child: Center(
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: LaunchScreenLayout
                                                          .tab4TextStyle,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    data["tab_4"][index][1],
                                                    style: LaunchScreenLayout
                                                        .tab4TextStyle,
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
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
      ],
    );
  }
}
