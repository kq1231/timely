import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/home/views/tab_buttons.dart';
import 'package:timely/modules/splash/views/splash.dart';
import 'package:timely/modules/tab_1/repositories/repo.dart';
import 'package:timely/reusables.dart';
export 'package:timely/modules/home/views/launch_screen.dart';
export 'package:timely/modules/splash/views/splash.dart';
export 'package:timely/modules/tab_1/atomic/pages/fms_page.dart';
export 'package:timely/modules/tab_1/atomic/pages/tab_1_output_page.dart';
export 'package:timely/modules/tab_10/atomic/pages/output/tab_10_output_page.dart';
export 'package:timely/modules/tab_11/atomic/pages/output/tab_11_output_page.dart';
export 'package:timely/modules/tab_12/atomic/pages/output/tab_12_summary_page.dart';
export 'package:timely/modules/tab_2/pages/tab_2_output_page.dart';
export 'package:timely/modules/tab_3/atomic/pages/output/tab_3_output_page.dart';
export 'package:timely/modules/tab_5/atomic/pages/output/tab_5_output_page.dart';
export 'package:timely/modules/tab_6/pages/tab_6_output_page.dart';
export 'package:timely/modules/tab_7/pages/tab_7_output_page.dart';
export 'package:timely/modules/tab_8/atomic/pages/output/tab_8_output_page.dart';
export 'package:timely/modules/tab_9/atomic/pages/output/tab_9_summary_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appDarkTheme,
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          ref.read(dbFilesProvider.future),
          ref.read(tab1RepositoryProvider.notifier).createDefaultEntry(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Scaffold(
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
                              onPressed: () {},
                              icon: const Icon(Icons.settings)),
                        )
                      ],
                    ),
                    body: tabs[ref.watch(tabIndexProvider)],
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
