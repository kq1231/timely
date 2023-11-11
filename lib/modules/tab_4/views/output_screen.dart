import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_4/controllers/output_controller.dart';

class Tab4OutputScreen extends ConsumerWidget {
  const Tab4OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab4OutputProvider);
    return provider.when(
      data: (data) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Center(
              child: Text(data[index].text_1),
            );
          },
          itemCount: data.length,
        );
      },
      error: (_, __) => const Text("ERROR"),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
