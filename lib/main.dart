import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/home/views/tab_buttons.dart';
import 'package:timely/modules/tab_1/repositories/pending_repo.dart';
import 'package:timely/reusables.dart';
import 'package:timely/tokens/app/themes/app_dark_theme.dart';
import 'exports/screens.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
          ref
              .read(tab1PendingRepositoryProvider.notifier)
              .updateNextUpdateTime(),
          // ref.read(dbFilesProvider.future),
          // ToAsk Inshaa Allah: Will this initialise and maintain the [File]s?
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
