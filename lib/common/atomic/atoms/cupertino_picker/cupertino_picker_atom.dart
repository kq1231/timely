import 'package:flutter/cupertino.dart';

class CupertinoPickerAtom extends StatelessWidget {
  final double itemExtent;
  final List<String> elements;
  final int initialItemIndex;
  final Size size;
  final ValueChanged<int>? onSelectedItemChanged;
  final Color? containerColor;
  final Color? selectionOverlayColor;

  const CupertinoPickerAtom({
    super.key,
    required this.itemExtent,
    required this.onSelectedItemChanged,
    required this.elements,
    required this.initialItemIndex,
    required this.size,
    this.containerColor,
    this.selectionOverlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: containerColor,
      width: size.width,
      height: size.height,
      child: CupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: initialItemIndex),
        itemExtent: itemExtent,
        onSelectedItemChanged: onSelectedItemChanged,
        selectionOverlay: selectionOverlayColor != null
            ? Container(
                color: selectionOverlayColor,
              )
            : const CupertinoPickerDefaultSelectionOverlay(),
        children: elements
            .map((e) => Center(child: Text(e)))
            .toList(), // Pass down the color to the picker
      ),
    );
  }
}
