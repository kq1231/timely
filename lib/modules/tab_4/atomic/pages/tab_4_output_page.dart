import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/atomic/pages/input/tab_3_input_page.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';
import 'package:timely/modules/tab_4/atomic/templates/tab_4_output_template.dart';
import 'package:timely/modules/tab_4/controllers/output_controller.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';
import 'package:timely/reusables.dart';

class Tab4OutputPage extends ConsumerStatefulWidget {
  const Tab4OutputPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Tab4OutputPageState();
}

class _Tab4OutputPageState extends ConsumerState<Tab4OutputPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tab4OutputProvider);

    return provider.when(
      data: (models) {
        return Tab4OutputTemplate(
          models: models,
          onDismissed: (direction, index) {
            if (direction == DismissDirection.startToEnd) {
              ref
                  .read(tab4RepositoryProvider.notifier)
                  .deleteModel(models[index]);
              models
                  .removeWhere((element) => element.uuid == models[index].uuid);
              setState(() {});
            } else {
              ref
                  .read(tab4RepositoryProvider.notifier)
                  .markModelAsComplete(models[index]);
              models.removeWhere((e) => e.uuid == models[index].uuid);
              setState(() {});
            }
          },
          onTap: (index) {
            ref.read(tab3InputProvider.notifier).setModel(models[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    body: const Tab3InputPage(
                      removeDateTime: true,
                    ),
                    appBar: AppBar(),
                  );
                },
              ),
            );
          },
          onPressedHome: () => ref.read(tabIndexProvider.notifier).setIndex(12),
          onPressedAdd: () {
            ref.invalidate(tab3InputProvider);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    body: const Tab3InputPage(
                      removeDateTime: true,
                    ),
                    appBar: AppBar(),
                  );
                },
              ),
            );
          },
        );
      },
      error: (_, __) => const Text("ERROR"),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
