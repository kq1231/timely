import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/views/tab_one/input_screens/tab_one_input_screen.dart';
import 'package:timely/views/tab_one/output_screens/tab_one_output_screen_a.dart';
// import 'package:timely/views/tab_one/tab_one_input_screen.dart';
import 'package:timely/views/tab_one/output_screens/tab_one_output_screen_c.dart';

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
      home: const DefaultTabController(
          length: 3, child: MyHomePage(title: 'Timely')),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const TabBar(tabs: [
          Tab(text: "Tab 1 Input"),
          Tab(text: "Tab 1 Output A"),
          Tab(text: "Tab 1 Output C"),
        ]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const TabBarView(children: [
        TabOneInputScreen(),
        TabOneOutputScreenA(),
        TabOneOutputScreenC(),
      ]),
    );
  }
}
