import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/atomic/templates/fms_template.dart';
import 'package:timely/modules/tab_1/controllers/fms_provider.dart';
import 'package:timely/modules/tab_1/providers/fms_provider.dart';

class FMSPage extends ConsumerStatefulWidget {
  const FMSPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FMSPageState();
}

class _FMSPageState extends ConsumerState<FMSPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(fmsModelProvider);

    return provider.when(
      data: (model) {
        final fmsCont = ref.read(fmsProvider(model).notifier);

        return StatefulBuilder(
          builder: (context, setState) {
            final model_1 = ref.read(fmsProvider(model));
            return FMSTemplate(
              indices: [model_1.fStatus, model_1.mStatus, model_1.sStatus],
              model: model_1,
              onStatusChanged: (index, status) {
                [
                  fmsCont.setFStatus,
                  fmsCont.setMStatus,
                  fmsCont.setSStatus,
                ][index](status);

                setState(() {});
              },
              timerFunction: (timer, status, index) async {
                if (status == 0) {
                  [
                    fmsCont.incrementFScore,
                    fmsCont.incrementMScore,
                    fmsCont.incrementSScore,
                  ][index]();
                }

                fmsCont.syncToDB();
                setState(() {});
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
