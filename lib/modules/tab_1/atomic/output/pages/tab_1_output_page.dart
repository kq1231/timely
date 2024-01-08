import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/atomic/output/templates/tab_1_output_template.dart';
import 'package:timely/modules/tab_1/controllers/input_controller.dart';
import 'package:timely/modules/tab_1/controllers/output_controller.dart';
import 'package:timely/modules/tab_1/views/input_screen.dart';
import 'package:timely/reusables.dart';

class Tab1OutputPage extends ConsumerStatefulWidget {
  const Tab1OutputPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Tab1OutputPageState();
}

class _Tab1OutputPageState extends ConsumerState<Tab1OutputPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab1OutputProvider);
    final controller = ref.read(tab1OutputProvider.notifier);

    return provider.when(
        data: (models) {
          return Tab1OutputTemplate(
            models: models,
            onPressedHome: () {
              ref.read(tabIndexProvider.notifier).setIndex(12);
            },
            onPressedAdd: () {
              ref.invalidate(tab1InputProvider);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                        appBar: AppBar(), body: const Tab1InputScreen());
                  },
                ),
              );
            },
            onEntryDismissed: (direction, index) async {
              if (direction == DismissDirection.startToEnd) {
                controller.deleteModel(models[index]);
                models.removeWhere(
                    (element) => element.date == models[index].date);

                setState(() {});
              } else {
                controller.markModelAsComplete(models[index]);
                models.removeWhere((e) => e.date == models[index].date);

                setState(() {});
              }
            },
            onEntryTap: (index) {
              ref.read(tab1InputProvider.notifier).setModel(models[index]);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                        appBar: AppBar(), body: const Tab1InputScreen());
                  },
                ),
              );
            },
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
