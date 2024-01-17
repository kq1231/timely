import 'package:flutter/material.dart';
import 'package:timely/common/atomic/atoms/atoms.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/common/atomic/organisms/organisms.dart';
import 'package:timely/modules/tab_5/models/spw.dart';
import 'package:timely/tokens/app/app.dart';

class Tab5InputTemplate extends StatelessWidget {
  final SPWModel model;
  final void Function(DateTime date) onDateChanged;
  final List<Function(int index)> onSelectedItemsChangedList;
  final void Function(String weight) onWeightChanged;
  final VoidCallback onSubmitPressed;
  final VoidCallback onCancelPressed;

  const Tab5InputTemplate({
    super.key,
    required this.model,
    required this.onDateChanged,
    required this.onSelectedItemsChangedList,
    required this.onWeightChanged,
    required this.onSubmitPressed,
    required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),

        // Date Button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DateButtonAtom.large(
              initialDate: model.date,
              onDateChanged: onDateChanged,
            ),
          ],
        ),

        const Divider(
          height: 40,
        ),

        // Row of Cupertino Pickers
        CupertinoPickerRowOrganism(
          headers: "S,B,W".split(",").map((e) => "$e Score").toList(),
          labels: [
            "Good,Fair,Poor".split(","),
            "Good,Fair,Poor".split(","),
            "Good,Fair,Poor".split(","),
          ],
          onSelectedItemsChangedList: onSelectedItemsChangedList,
          pickerContainerColors: [
            AppColors.bgIndigo800,
            AppColors.bgIndigo700,
            AppColors.bgIndigo800
          ],
          pickerHeight: 120,
          initialItemIndices: [model.sScore, model.pScore, model.wScore],
        ),

        const Divider(
          height: 40,
        ),

        // Weight Text Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_16),
          child: TextFormFieldAtom(
            initialValue: model.weight != null ? model.weight.toString() : "",
            onChanged: onWeightChanged,
            hintText: "Weight",
          ),
        ),

        const Divider(
          height: 40,
        ),

        // Cancel Submit Row
        CancelSubmitRowMolecule(
          onSubmitPressed: onSubmitPressed,
          onCancelPressed: onCancelPressed,
        ),

        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
