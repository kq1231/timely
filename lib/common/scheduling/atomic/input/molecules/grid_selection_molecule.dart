import 'package:flutter/material.dart';
import 'package:timely/common/scheduling/tokens/scheduling_colors.dart';

class GridSelectionMolecule extends StatefulWidget {
  final List<String> texts;
  final Function(List<int> selections) onSelectionsChanged;
  final List<int> selections;
  const GridSelectionMolecule({
    super.key,
    required this.texts,
    required this.onSelectionsChanged,
    required this.selections,
  });

  @override
  State<GridSelectionMolecule> createState() => _GridSelectionMoleculeState();
}

// Will return a function "onTap(List indices)"
// InshaaAllah

class _GridSelectionMoleculeState extends State<GridSelectionMolecule> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              widget.selections.contains(index)
                  ? widget.selections.remove(index)
                  : widget.selections.add(index);

              widget.onSelectionsChanged(widget.selections);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: widget.selections.contains(index)
                  ? SchedulingColors.bgSelected
                  : SchedulingColors.bgDeselected,
            ),
            alignment: Alignment.center,
            child: Text(
              widget.texts[index].toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
      itemCount: widget.texts.length,
    );
  }
}
