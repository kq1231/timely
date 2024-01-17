import 'package:flutter/material.dart';
import 'package:timely/common/atomic/atoms/atoms.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/common/atomic/organisms/organisms.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';
import 'package:timely/tokens/app/app.dart';

class Tab8InputTemplate extends StatelessWidget {
  final Tab8Model model;
  final void Function(DateTime date) onDateChanged;
  final void Function(int index) onLSJChanged;
  final void Function(int index) onPriorityChanged;
  final void Function(String title) onTitleChanged;
  final void Function(String description) onDescriptionChanged;

  final VoidCallback onSubmitPressed;
  final VoidCallback onCancelPressed;

  const Tab8InputTemplate({
    super.key,
    required this.model,
    required this.onDateChanged,
    required this.onLSJChanged,
    required this.onPriorityChanged,
    required this.onSubmitPressed,
    required this.onCancelPressed,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),

        // |--| Item Text Field
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
          height: 60,
        ),

        // |--| Quantity Text Field
        Column(
          children: [
            CupertinoPickerRowOrganism(
              headers: const ["LSJ", "Priority"],
              labels: [
                const ["L", "S", "J"],
                "High,Medium,Low".split(","),
              ],
              onSelectedItemsChangedList: [
                (index) => onLSJChanged(index),
                (index) => onPriorityChanged(index),
              ],
              pickerContainerColors: [
                AppColors.bgIndigo600,
                AppColors.bgIndigo800,
              ],
              pickerHeight: 140,
              initialItemIndices: [model.lsj, model.hml],
            ),
          ],
        ),
        const Divider(
          height: 60,
        ),

        // |--| Title Text Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_16),
          child: TextFormFieldAtom(
            initialValue: model.title,
            onChanged: onTitleChanged,
            hintText: "Title",
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // |--| Title Text Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_16),
          child: TextFormFieldAtom(
            initialValue: model.description,
            isTextArea: true,
            onChanged: onDescriptionChanged,
            hintText: "Description",
          ),
        ),

        const Divider(
          height: 60,
        ),

        // |--| Cancel Submit Buttons
        CancelSubmitRowMolecule(
          onSubmitPressed: onSubmitPressed,
          onCancelPressed: onCancelPressed,
        ),

        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
