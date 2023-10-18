import 'package:flutter/material.dart';
import 'package:timely/views/tab_one/input_screens/tab_one_input_screen.dart';
import 'package:timely/views/tab_one/output_screens/output_screen_a.dart';
import 'package:timely/views/tab_one/output_screens/output_screen_b.dart';
import 'package:timely/views/tab_one/output_screens/output_screen_c.dart';

class TabOneScreen extends StatefulWidget {
  const TabOneScreen({super.key});

  @override
  State<TabOneScreen> createState() => _TabOneScreenState();
}

class _TabOneScreenState extends State<TabOneScreen> {
  int currentlySelectedScreenIndex = 0;
  final List tabs = const [
    TabOneInputScreen(),
    TabOneOutputScreenA(),
    TabOneOutputScreenB(),
    TabOneOutputScreenC()
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          SegmentedButton(
            segments: const [
              ButtonSegment(
                value: 0,
                label: Text(
                  "Input",
                  softWrap: false,
                ),
              ),
              ButtonSegment(
                value: 1,
                label: Text("A"),
              ),
              ButtonSegment(
                value: 2,
                label: Text("B"),
              ),
              ButtonSegment(
                value: 3,
                label: Text("C"),
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
          const SizedBox(
            height: 20,
          ),
          tabs[currentlySelectedScreenIndex], // The currently selected tab.
        ],
      ),
    );
  }
}
