import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/layout_params.dart';
import 'package:timely/views/launch_screen/launch_ui_screen.dart';
import 'package:timely/views/tab_one/tab_one_screen.dart';

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
      home: const MyHomePage(title: 'Timely'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTabIndex = 0;
  final List tabs = [const LaunchScreen(), const TabOneScreen()];
  final tabIcons = [launchScreenIcon, tabOneIcon];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          const SizedBox(
            width: 7,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                for (int i in Iterable.generate(tabs.length))
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            currentTabIndex = i;
                            setState(() {});
                          },
                          child: tabIcons[i]),
                    ),
                  )
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(child: tabs[currentTabIndex]),
        ],
      ),
    );
  }
}
