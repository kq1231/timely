import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_5/views/output_screen.dart';
import 'package:timely/modules/tab_1/views/tab_one_output_screen.dart';
import 'package:timely/app_themes.dart';
import 'package:timely/modules/home/views/launch_screen.dart';
import 'package:timely/reusables.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

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
  Widget build(BuildContext context) {
    int currentTabIndex = ref.watch(tabIndexProvider);
    var provider = ref.read(tabIndexProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Timely"),
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
