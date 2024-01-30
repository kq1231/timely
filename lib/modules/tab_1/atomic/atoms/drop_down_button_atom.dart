import 'package:flutter/material.dart';

class DropdownButtonAtom extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final int selectedIndex;
  final void Function(dynamic value) onChanged;
  const DropdownButtonAtom({
    super.key,
    required this.items,
    required this.onChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedIndex,
      items: items,
      onChanged: onChanged,
    );
  }
}
