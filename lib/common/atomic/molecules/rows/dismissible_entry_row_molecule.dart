import 'package:flutter/material.dart';

class DismissibleEntryRowMolecule extends StatelessWidget {
  final Widget child;
  final Function(DismissDirection direction) onDismissed;

  const DismissibleEntryRowMolecule({
    Key? key,
    required this.child,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        return await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: direction == DismissDirection.startToEnd
                      ? const Text("Delete")
                      : const Text("Mark Complete"),
                  content: direction == DismissDirection.startToEnd
                      ? const Text('Are you sure you want to delete?')
                      : const Text(
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
      },
      onDismissed: (direction) => onDismissed(direction),
      child: child,
    );
  }
}
