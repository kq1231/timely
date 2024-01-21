import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/atomic/output/repages/output_template.dart';
import 'package:timely/common/scheduling/controllers/input_controller.dart';
import 'package:timely/common/scheduling/controllers/output_controller.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/modules/tab_2/pages/tab_2_input_page.dart';
import 'package:timely/reusables.dart';

class SchedulingOutputRepage extends ConsumerStatefulWidget {
  final AsyncNotifierProvider<Tab2OutputNotifier, List<Tab2Model>>
      providerOfTab2Models;

  const SchedulingOutputRepage({super.key, required this.providerOfTab2Models});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Tab2OutputRepageState();
}

class _Tab2OutputRepageState extends ConsumerState<SchedulingOutputRepage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(widget.providerOfTab2Models);
    final controller = ref.read(widget.providerOfTab2Models.notifier);

    return provider.when(
        data: (models) {
          return SchedulingOutputTemplate(
            onDismissed: (DismissDirection direction, int index) {
              if (direction == DismissDirection.startToEnd) {
                controller.deleteModel(models[index]);
                models.removeWhere(
                    (element) => element.uuid == models[index].uuid);
                setState(() {});
              } else {
                models.removeWhere((e) => e.uuid == models[index].uuid);
                setState(() {});

                controller.markModelAsComplete(models[index]);
              }
            },
            onTap: (index) {
              ref.read(tab2InputProvider.notifier).setModel(models[index]);
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
                      body: const Tab2InputPage(),
                      appBar: AppBar(),
                    );
                  },
                ),
              );
            },
            showEndTime: true,
            models: models,
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
