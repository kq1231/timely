import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/repositories/tab_one_repo.dart';
import 'package:timely/modules/tab_5/views/output_screen.dart';
import 'package:timely/modules/tab_1/views/tab_one_output_screen.dart';
import 'package:timely/app_theme.dart';
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
    return FutureBuilder(
        future: Future.wait([
          ref.read(tabOneRepositoryProvider.notifier).createDefaultEntry(),
          ref.read(tabOneRepositoryProvider.notifier).updateNextUpdateTime()
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
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
                                    side: BorderSide(
                                        color: Colors.black38, width: 0.1),
                                  ),
                                  heroTag: null,
                                  onPressed: () {
                                    ref
                                        .read(tabIndexProvider.notifier)
                                        .setIndex(i);
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
                      Expanded(child: tabs[ref.watch(tabIndexProvider)]),
                      const VerticalDivider(
                        width: 2,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Scaffold(
              body: Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Initializing...",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: const LinearProgressIndicator())
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            );
          }
        });
  }
}
