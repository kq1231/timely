import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/views/fms_template.dart';
import 'package:timely/modules/tab_1/controllers/fms_provider.dart';
import 'package:timely/modules/tab_1/providers/todays_fms_provider.dart';
import 'package:timely/modules/tab_1/views/status_row.dart';

class FMSPage extends ConsumerStatefulWidget {
  const FMSPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FMSPageState();
}

class _FMSPageState extends ConsumerState<FMSPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(todaysFMSProvider);

    return provider.when(
      data: (model) {
        final fmsModel = ref.watch(
          fmsProvider(model),
        );
        final fmsController = ref.read(fmsProvider(model).notifier);

        return FMSTemplate(
          model: fmsModel,
          onTap: (index) async {
            List statuses = [
              ref.read(fmsProvider(model)).mStatus,
              ref.read(fmsProvider(model)).fStatus,
              ref.read(fmsProvider(model)).sStatus
            ];

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirmation'),
                  content: SizedBox(
                    height: 120,
                    child: Column(
                      children: [
                        const Text('Select an Option'),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StatefulBuilder(builder: (ctx, setState) {
                              return StatusRowMolecule(
                                  status: statuses[index],
                                  onStatusChanged: (st) {
                                    setState(() {
                                      statuses[index] = st;
                                    });
                                  },
                                  locked: false);
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Confirm'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        [
                          fmsController.setMStatus,
                          fmsController.setFStatus,
                          fmsController.setSStatus,
                        ][index](statuses[index]);

                        await fmsController.syncToDB();
                      },
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      error: (_, __) => const Text("ERROR"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

bool isLocked({required int status, DateTime? time}) {
  if (status == 2) // Yani status is "Pause"
  {
    return true;
  } else if (status == 1) // Yani status is "Stop"
  {
    // Check if the time elapsed is half-an-hour or more
    if ((DateTime.now().difference(time!).inSeconds / 60) >= 30) {
      return false; // Yani it is unlocked
    } else {
      return true;
    }
  } else {
    return false;
  }
}
