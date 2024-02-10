import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/controllers/input_controller.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/home/atomic/templates/external_entries_template.dart';
import 'package:timely/modules/home/controllers/remaining_time_ticker.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/home/providers/external_entries_provider.dart';
import 'package:timely/modules/home/views/tab_buttons.dart';
import 'package:timely/modules/tab_1/atomic/pages/fms_page.dart';
import 'package:timely/modules/tab_2/pages/tab_2_input_page.dart';
import 'package:timely/modules/tab_3/atomic/pages/input/tab_3_input_page.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';

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
                        onDismissed: (dir, model) {
                          // if (model is Tab3Model) {}
                        },
                        onTap: (model, index) {
                          if (model is Tab3Model) {
                            ref
                                .read(tab3InputProvider.notifier)
                                .setModel(model);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(),
                                    body: const Tab3InputPage(),
                                  );
                                },
                              ),
                            );
                          } else if (model is Tab2Model) {
                            ref
                                .read(tab2InputProvider.notifier)
                                .setModel(model);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    body: const Tab2InputPage(),
                                    appBar: AppBar(),
                                  );
                                },
                              ),
                            );
                          }
                        },
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
