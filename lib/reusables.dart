import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// Providers
final colorProvider = Provider<List<Color>>((ref) {
  return [
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red
  ];
});

final dbFilesProvider = FutureProvider<Map<int, List<File>>>((ref) async {
  Directory docDir = await getApplicationDocumentsDirectory();
  Map<int, List<File>> files = {};

  for (int i in List.generate(12, (index) => index + 1)) {
    File pending = File('${docDir.path}/tab_${i}_pending.json');
    File completed = File('${docDir.path}/tab_${i}_completed.json');

    for (File file in [pending, completed]) {
      await file.create();
      if ((await file.readAsString()).isEmpty) {
        if (![1, 3, 5].contains(i)) {
          await file.writeAsString("[]");
        } else {
          await file.writeAsString("{}");
        }
      }
    }

    files[i] = [
      pending,
      completed,
    ];
  }

  files[2] = [
    ...files[2]!,
    File('${docDir.path}/tab_2_current_activities.json')
  ];

  return files;
});

class TabIndex extends StateNotifier<int> {
  TabIndex() : super(12);

  void setIndex(int index) {
    state = index;
  }
}

final tabIndexProvider =
    StateNotifierProvider<TabIndex, int>((ref) => TabIndex());

class DismissibleEntry extends StatefulWidget {
  final String entryKey;
  final Widget child;
  final DismissDirectionCallback? onDismissed;

  const DismissibleEntry(
      {super.key,
      required this.entryKey,
      required this.child,
      required this.onDismissed});

  @override
  State<DismissibleEntry> createState() => _DismissibleEntryState();
}

class _DismissibleEntryState extends State<DismissibleEntry> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          return await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete"),
                    content: const Text('Are you sure you want to delete?'),
                    actions: [
                      IconButton.filledTonal(
                          icon: const Icon(Icons.done),
                          onPressed: () => Navigator.pop(context, true)),
                      IconButton.filled(
                          icon: const Icon(Icons.dangerous),
                          onPressed: () => Navigator.pop(context, false)),
                    ],
                  );
                },
              ) ??
              false;
        } else {
          return await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Mark Complete"),
                    content: const Text(
                        'Are you sure you want to mark as completed?'),
                    actions: [
                      IconButton.filledTonal(
                        icon: const Icon(Icons.done),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                      IconButton.filled(
                        icon: const Icon(Icons.dangerous),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ],
                  );
                },
              ) ??
              false;
        }
      },
      key: UniqueKey(),
      onDismissed: widget.onDismissed,
      background: Container(color: Colors.red),
      child: widget.child,
    );
  }
}
