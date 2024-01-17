import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/exports/screens.dart';
import 'package:timely/modules/tab_1/atomic/output/pages/tab_1_output_page.dart';
import 'package:timely/modules/tab_10/atomic/pages/output/tab_10_output_page.dart';
import 'package:timely/modules/tab_11/atomic/pages/output/tab_11_output_page.dart';
import 'package:timely/modules/tab_2/pages/tab_2_output_page.dart';
import 'package:timely/modules/tab_3/atomic/pages/output/tab_3_output_page.dart';
import 'package:timely/modules/tab_4/atomic/pages/tab_4_output_page.dart';
import 'package:timely/modules/tab_5/atomic/pages/output/tab_5_output_page.dart';
import 'package:timely/modules/tab_6/pages/tab_6_output_page.dart';
import 'package:timely/modules/tab_7/pages/tab_7_output_page.dart';
import 'package:timely/modules/tab_8/atomic/pages/output/tab_8_output_page.dart';
import 'package:timely/reusables.dart';

final List tabs = [
  const Tab1OutputPage(),
  const Tab2OutputPage(),
  const Tab3OutputPage(),
  const Tab4OutputPage(),
  const Tab5OutputPage(),
  const Tab6OutputPage(),
  const Tab7OutputPage(),
  const Tab8OutputPage(),
  const Tab9SummaryScreen(),
  const Tab10OutputPage(),
  const Tab11OutputPage(),
  const Tab12SummaryScreen(),
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
