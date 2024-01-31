import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/atomic/templates/fms_template.dart';
import 'package:timely/modules/tab_1/controllers/fms_provider.dart';
import 'package:timely/modules/tab_1/providers/todays_fms_provider.dart';

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
          onStatusChanged: (index, status) async {
            [
              fmsController.setFStatus,
              fmsController.setMStatus,
              fmsController.setSStatus,
            ][index](status);

            fmsController.syncToDB();
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
