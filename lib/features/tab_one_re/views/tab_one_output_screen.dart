import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_one_re/controllers/output_controller.dart';

class TabFiveOutputScreen extends ConsumerWidget {
  const TabFiveOutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tabOneFutureProvider);
    return provider.when(
        data: (data) {
          return Stack(
            children: [],
          );
        },
        error: (_, __) => const Text("ERROR"),
        loading: () => const CircularProgressIndicator());
  }
}
