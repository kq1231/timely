import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/views/templates/tab_1_output_template.dart';
import 'package:timely/modules/tab_1/providers/fms_models_provider.dart';
import 'package:timely/reusables.dart';

class Tab1OutputPage extends ConsumerWidget {
  const Tab1OutputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerOfFMSModels = ref.watch(fmsModelsProvider);

    return providerOfFMSModels.when(
        data: (models) {
          return Tab1OutputTemplate(
            models: models,
            onPressedHome: () =>
                ref.read(tabIndexProvider.notifier).setIndex(12),
          );
        },
        error: (_, __) => const Text("Error"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
