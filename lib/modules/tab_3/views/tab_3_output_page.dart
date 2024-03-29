import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/views/tab_3_input_page.dart';
import 'package:timely/modules/tab_3/views/tab_3_output_template.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';
import 'package:timely/modules/tab_3/controllers/output_controller.dart';
import 'package:timely/reusables.dart';

class Tab3OutputPage extends ConsumerStatefulWidget {
  const Tab3OutputPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Tab3OutputPageState();
}

class _Tab3OutputPageState extends ConsumerState<Tab3OutputPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab3OutputProvider);
    final controller = ref.read(tab3OutputProvider.notifier);

    return provider.when(
        data: (models) {
          return Tab3OutputTemplate(
            models: models,
            onDismissed: (direction, model) {
              if (direction == DismissDirection.startToEnd) {
                controller.deleteModel(model);
              } else {
                controller.markModelAsComplete(model);
              }
            },
            onTap: (model) {
              ref.read(tab3InputProvider.notifier).setModel(model);
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
            },
            onPressedHome: () =>
                ref.read(tabIndexProvider.notifier).setIndex(12),
            onPressedAdd: () {
              ref.invalidate(tab3InputProvider);
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
            },
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
