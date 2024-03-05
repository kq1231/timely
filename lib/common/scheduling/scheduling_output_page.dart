import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/output_template.dart';
import 'package:timely/common/scheduling/input_controller.dart';
import 'package:timely/common/scheduling/output_controller.dart';
import 'package:timely/common/scheduling/scheduling_model.dart';
import 'package:timely/reusables.dart';

class SchedulingOutputPage extends ConsumerStatefulWidget {
  final AutoDisposeAsyncNotifierProvider<SchedulingOutputNotifier,
      Map<String, List<SchedulingModel>>> providerOfTab2Models;
  final Widget inputPage;
  final bool? showEndTime;

  const SchedulingOutputPage({
    super.key,
    required this.providerOfTab2Models,
    required this.inputPage,
    this.showEndTime,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab2OutputRepageState();
}

class _Tab2OutputRepageState extends ConsumerState<SchedulingOutputPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(widget.providerOfTab2Models);
    final controller = ref.read(widget.providerOfTab2Models.notifier);

    return provider.when(
        data: (models) {
          return SchedulingOutputTemplate(
            onDismissed: (DismissDirection direction, SchedulingModel model,
                String type) {
              if (direction == DismissDirection.startToEnd) {
                controller.deleteModel(model);
                models[type]!
                    .removeWhere((element) => element.uuid == model.uuid);
                setState(() {});
              } else {
                models[type]!.removeWhere((e) => e.uuid == model.uuid);
                setState(() {});

                // controller.markModelAsComplete(models[index]);
              }
            },
            onTap: (SchedulingModel model) {
              ref.read(tab2InputProvider.notifier).setModel(model);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: widget.inputPage,
                      appBar: AppBar(),
                    );
                  },
                ),
              );
            },
            onPressedHome: () {
              ref.read(tabIndexProvider.notifier).setIndex(12);
            },
            onPressedAdd: () {
              ref.invalidate(tab2InputProvider);
              ref
                  .read(tab2InputProvider.notifier)
                  .setDuration(const Duration(hours: 0, minutes: 30));

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: widget.inputPage,
                      appBar: AppBar(),
                    );
                  },
                ),
              );
            },
            showEndTime: widget.showEndTime,
            models: models,
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
