import 'package:flutter/material.dart';

class NavigationRowMolecule extends StatelessWidget {
  final VoidCallback onPressedHome;
  final VoidCallback onPressedAdd;

  const NavigationRowMolecule({
    Key? key,
    required this.onPressedHome,
    required this.onPressedAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          heroTag: null,
          onPressed: onPressedHome,
          child: const Icon(Icons.home),
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: onPressedAdd,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
