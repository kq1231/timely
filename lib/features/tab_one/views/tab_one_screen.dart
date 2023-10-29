import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_one/views/input_screens/tab_one_input_screen.dart';
import 'package:timely/features/tab_one/views/output_screens/output_screen_a.dart';
import 'package:timely/features/tab_one/views/output_screens/output_screen_b.dart';
import 'package:timely/features/tab_one/views/output_screens/output_screen_c.dart';
import 'package:timely/layout_params.dart';
import 'package:timely/public_providers.dart/tab_index_provider.dart';

class TabOneScreen extends ConsumerStatefulWidget {
  const TabOneScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabOneScreenState();
}

class _TabOneScreenState extends ConsumerState<TabOneScreen> {
  int currentlySelectedScreenIndex = 0;
  final List tabs = const [
    TabOneOutputScreenA(),
    TabOneOutputScreenB(),
    TabOneOutputScreenC()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                ref.read(tabIndexProvider.notifier).setIndex(12);
              },
              child: launchScreenIcon,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                        body: const TabOneInputScreen(),
                        appBar: AppBar(
                          title: const Text("Tab One Input Screen"),
                        ),
                      );
                    },
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SegmentedButton(
            segments: [
              ButtonSegment(
                value: 0,
                label: Text(tabOneOutputScreenSegButtonText_1),
              ),
              ButtonSegment(
                value: 1,
                label: Text(tabOneOutputScreenSegButtonText_2),
              ),
              ButtonSegment(
                value: 2,
                label: Text(tabOneOutputScreenSegButtonText_3),
              ),
            ],
            selected: {
              currentlySelectedScreenIndex,
            },
            onSelectionChanged: (p0) {
              currentlySelectedScreenIndex = p0.first;
              setState(() {});
            },
          ),

          tabs[currentlySelectedScreenIndex], // The currently selected tab.
        ],
      ),
    );
  }
}
