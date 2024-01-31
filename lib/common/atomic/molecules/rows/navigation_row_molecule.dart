import 'package:flutter/material.dart';

class NavigationRowMolecule extends StatelessWidget {
  final VoidCallback onPressedHome;
  final VoidCallback? onPressedAdd;
  final bool? hideAddButton;

  const NavigationRowMolecule(
      {Key? key,
      required this.onPressedHome,
      this.onPressedAdd,
      this.hideAddButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: hideAddButton == true
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceAround,
      children: [
        FloatingActionButton(
          heroTag: null,
          onPressed: onPressedHome,
          child: const Icon(Icons.home),
        ),
        hideAddButton == true
            ? Container()
            : FloatingActionButton(
                heroTag: null,
                onPressed: onPressedAdd,
                child: const Icon(Icons.add),
              ),
      ],
    );
  }
}
