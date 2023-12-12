import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_1/repositories/tab_one_repo.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/tab_2_6_7/tab_2/views/output_screen.dart';
import 'package:timely/modules/tab_2_6_7/tab_6/views/output_screen.dart';
import 'package:timely/modules/tab_2_6_7/tab_7/views/output_screen.dart';
import 'package:timely/reusables.dart';
import 'exports/screens.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        home: const MyHomePage(),
      ),
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
    const Tab1OutputScreen(),
    const Tab2OutputScreen(),
    const Tab3OutputScreen(),
    const Tab4OutputScreen(),
    const Tab5OutputScreen(),
    const Tab6OutputScreen(),
    const Tab7OutputScreen(),
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
          ref.read(tab1RepositoryProvider.notifier).updateNextUpdateTime(),
          // ref.read(dbFilesProvider.future),
          // ToAsk Inshaa Allah: Will this initialise and maintain the [File]s?
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                int selectedIndex = ref.read(tabIndexProvider);
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: Text(
                      DateFormat(DateFormat.ABBR_MONTH_DAY).format(
                        DateTime.now(),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: IconButton.outlined(
                            onPressed: () {}, icon: const Icon(Icons.settings)),
                      )
                    ],
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
                                  backgroundColor: i != selectedIndex
                                      ? tabColors[i]
                                      : Colors
                                          .purple, // Add color for selected Tab
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
            return const SplashScreen();
          }
        });
  }
}
