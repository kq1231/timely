import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/views/input_screen.dart';
import 'package:timely/modules/tab_4/controllers/output_controller.dart';
import 'package:timely/reusables.dart';

class Tab4OutputScreen extends ConsumerWidget {
  const Tab4OutputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab4OutputProvider);
    return provider.when(
      data: (data) {
        return Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const Divider(),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Center(
                              child: Text([
                                "High",
                                "Medium",
                                "Low"
                              ][data[index].priority]),
                            ),
                          ),
                          Expanded(
                              child: Center(child: Text(data[index].text_1))),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
              itemCount: data.length,
            ),
            Column(
              children: [
                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      child: const Icon(Icons.home),
                      onPressed: () =>
                          ref.read(tabIndexProvider.notifier).setIndex(12),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      child: const Icon(Icons
                          .add), // Text(DateTime.now().toString().substring(5, 10)),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Tab3InputScreen();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            )
          ],
        );
      },
      error: (_, __) => const Text("ERROR"),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
