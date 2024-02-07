import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/atomic/templates/external_entries_template.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/home/providers/external_entries_provider.dart';
import 'package:timely/modules/home/views/tab_buttons.dart';
import 'package:timely/modules/tab_1/atomic/pages/fms_page.dart';

class LaunchScreen extends ConsumerWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tabsData = ref.watch(externalEntriesProvider);
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
                    Container(
                      color: Colors.black,
                      child: const Center(
                        child: Text(
                          "Internal",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.indigo[900],
                        child: const FMSPage(),
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      child: const Center(
                        child: Text(
                          "External",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ExternalEntriesTemplate(
                        color: Colors.black,
                        data: data,
                        onTap: () {},
                      ),
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
