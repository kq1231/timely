import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/rows/title_widget_row_molecule.dart';
import 'package:timely/common/scheduling/atomic/input/molecules/grid_selection_molecule.dart';
import 'package:timely/common/scheduling/atomic/input/molecules/ordinal_weekday_selection_molecule.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/tokens/app/app_sizes.dart';

class MonthlySelectionOrganism extends StatelessWidget {
  final Tab2Model model;

  final Function(List<int> selections) onSelectionsChanged;
  final Function(Basis basis) onBasisChanged;
  final Function(int index) onOrdinalPositionChanged;
  final Function(int index) onWeekdayIndexChanged;

  const MonthlySelectionOrganism({
    super.key,
    required this.onSelectionsChanged,
    required this.onBasisChanged,
    required this.onOrdinalPositionChanged,
    required this.onWeekdayIndexChanged,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Each
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_12),
          child: TitleWidgetRowMolecule(
            title: "Each",
            widget: Checkbox(
                value: model.basis == Basis.date ? true : false,
                onChanged: (val) =>
                    onBasisChanged(val == true ? Basis.date : Basis.day)),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // On the...
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_12),
          child: TitleWidgetRowMolecule(
            title: "On the...",
            widget: Checkbox(
              value: model.basis == Basis.day ? true : false,
              onChanged: (val) =>
                  onBasisChanged(val == true ? Basis.day : Basis.date),
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        GridSelectionMolecule(
          texts: List.generate(31, (index) => (++index).toString()),
          onSelectionsChanged: (selections) => onSelectionsChanged(selections),
        ),
        model.basis == Basis.day
            ? OrdinalWeekdaySelectionMolecule(
                onOrdinalPositionChanged: onOrdinalPositionChanged,
                onWeekdayIndexChanged: onWeekdayIndexChanged,
                initialOrdinalPosition: model.repetitions["DoW"][0],
                initialWeekdayIndex: model.repetitions["DoW"][1],
              )
            : Container(),
      ],
    );
  }
}