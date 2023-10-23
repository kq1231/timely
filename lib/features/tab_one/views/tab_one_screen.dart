import 'package:flutter/material.dart';
import 'package:timely/features/tab_one/views/input_screens/tab_one_input_screen.dart';
import 'package:timely/features/tab_one/views/output_screens/output_screen_a.dart';
import 'package:timely/features/tab_one/views/output_screens/output_screen_b.dart';
import 'package:timely/features/tab_one/views/output_screens/output_screen_c.dart';

class TabOneScreen extends StatefulWidget {
  const TabOneScreen({super.key});

  @override
  State<TabOneScreen> createState() => _TabOneScreenState();
}

class _TabOneScreenState extends State<TabOneScreen> {
  int currentlySelectedScreenIndex = 0;
  final List tabs = const [
    TabOneOutputScreenA(),
    TabOneOutputScreenB(),
    TabOneOutputScreenC()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            SegmentedButton(
              segments: const [
                ButtonSegment(
                  value: 0,
                  label: Text("A"),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text("B"),
                ),
                ButtonSegment(
                  value: 2,
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
      ),
    );
  }
}
