import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/home/repositories/tasks_today_repo.dart';
import 'package:timely/modules/home/views/tab_buttons.dart';
import 'package:timely/common/splash.dart';
import 'package:timely/modules/tab_1_new/incrementor.dart';
import 'package:timely/modules/tab_1_new/repository.dart';
import 'package:timely/reusables.dart';

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
          Future.delayed(Duration.zero, () async {
            // Initialize the files provider
            await ref.read(dbFilesProvider.future);

            // First, generate [Progress] model for today if it does not exist
            await ref
                .read(progressRepositoryProvider.notifier)
                .generateTodaysProgressData();

            // Once generated, start the incrementor timer
            ref.read(incrementorProvider.future);

            // Generate all tasks due today
            await ref
                .read(tasksTodayRepositoryProvider.notifier)
                .generateTodaysTasks();
          }),
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
