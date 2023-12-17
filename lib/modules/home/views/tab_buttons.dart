import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/exports/screens.dart';
import 'package:timely/modules/tab_11/views/output_screen.dart';
import 'package:timely/reusables.dart';

final List tabs = [
  const Tab1OutputScreen(),
  const Tab2OutputScreen(),
  const Tab3OutputScreen(),
  const Tab4OutputScreen(),
  const Tab5OutputScreen(),
  const Tab6OutputScreen(),
  const Tab7OutputScreen(),
  const Tab8OutputScreen(),
  const Center(child: Text("Coming Soon Inshaa Allah...")),
  const Tab10OutputScreen(),
  const Tab11OutputScreen(),
  const Center(child: Text("Coming Soon Inshaa Allah...")),
  const LaunchScreen(),
];

class TabButtons extends ConsumerStatefulWidget {
  const TabButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabButtonsState();
}

class _TabButtonsState extends ConsumerState<TabButtons> {
  final tabIcons = [
    for (int i in Iterable.generate(12))
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            (i + 1).toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
  ];

  final tabColors = [
    tabOneColor,
    tabTwoColor,
    tabThreeColor,
    tabFourColor,
    tabFiveColor,
    tabSixColor,
    tabSevenColor,
    tabEightColor,
    tabNineColor,
    tabTenColor,
    tabElevenColor,
    tabTwelveColor,
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex = ref.watch(tabIndexProvider);
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          for (int i in Iterable.generate(tabs.length - 1))
            Expanded(
              child: FloatingActionButton(
                backgroundColor: i != selectedIndex
                    ? tabColors[i]
                    : Colors.indigo, // Add color for selected Tab
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.black38, width: 0.1),
                ),
                heroTag: null,
                onPressed: () {
                  ref.read(tabIndexProvider.notifier).setIndex(i);
                },
                child: tabIcons[i],
              ),
            )
        ],
      ),
    );
  }
}
