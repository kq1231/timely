import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/atomic/input/templates/output_template.dart';
import 'package:timely/common/scheduling/controllers/input_controller.dart';
import 'package:timely/modules/tab_6/controllers/output_controller.dart';
import 'package:timely/modules/tab_6/pages/tab_6_input_page.dart';
import 'package:timely/reusables.dart';

class Tab6OutputPage extends ConsumerStatefulWidget {
  const Tab6OutputPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Tab6OutputPageState();
}

class _Tab6OutputPageState extends ConsumerState<Tab6OutputPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab6OutputProvider);
    final controller = ref.read(tab6OutputProvider.notifier);

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
                      body: Tab6InputPage(),
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
                      body: const Tab6InputPage(),
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
