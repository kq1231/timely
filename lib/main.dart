import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_five/views/output_screen.dart';
import 'package:timely/features/tab_one_re/views/tab_one_output_screen.dart';
import 'package:timely/layout_params.dart';
import 'package:timely/features/launch_screen/views/launch_screen.dart';
import 'package:timely/public_providers.dart/tab_index_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key});

  final List tabs = [
    const TabOneOutputScreen(),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const TabFiveOutputScreen(),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const Center(child: Text("Coming Soon Inshaa Allah...")),
    const LaunchScreen(),
  ];

  final tabIcons = [
    tabOneIcon,
    tabTwoIcon,
    tabThreeIcon,
    tabFourIcon,
    tabFiveIcon,
    tabSixIcon,
    tabSevenIcon,
    tabEightIcon,
    tabNineIcon,
    tabTenIcon,
    tabElevenIcon,
    tabTwelveIcon,
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
  Widget build(BuildContext context, WidgetRef ref) {
    int currentTabIndex = ref.watch(tabIndexProvider);
    var provider = ref.read(tabIndexProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Timely"),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 50,
            child: Column(
              children: [
                for (int i in Iterable.generate(tabs.length - 1))
                  Expanded(
                    child: FloatingActionButton(
                      backgroundColor: tabColors[i],
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.black38, width: 0.1),
                      ),
                      heroTag: null,
                      onPressed: () {
                        provider.setIndex(i);
                      },
                      child: tabIcons[i],
                    ),
                  )
              ],
            ),
          ),
          const VerticalDivider(
            width: 2,
          ),
          Expanded(child: tabs[currentTabIndex]),
          const VerticalDivider(
            width: 2,
          ),
        ],
      ),
    );
  }
}
