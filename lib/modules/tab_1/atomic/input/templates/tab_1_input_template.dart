import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/tokens/app/app.dart';
import 'package:timely/common/atomic/atoms/atoms.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/common/atomic/organisms/organisms.dart';
import 'package:timely/app_theme.dart';

class Tab1InputTemplate extends ConsumerWidget {
  final String initialText;
  final DateTime initialDate;
  final TimeOfDay initialTime;
  final Function(String text) onTextChanged;
  final Function(DateTime date) onDateChanged;
  final Function(TimeOfDay time) onTimeChanged;
  final VoidCallback onSubmitPressed;
  final List<Function(int index)> onPickerSelectionChangedList;
  final List<int> initialPickerItemsIndices;

  const Tab1InputTemplate({
    super.key,
    required this.initialText,
    required this.initialDate,
    required this.initialTime,
    required this.onTextChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onSubmitPressed,
    required this.onPickerSelectionChangedList,
    required this.initialPickerItemsIndices,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DateButtonAtom.large(
            initialDate: initialDate,
            onDateChanged: (date) => onDateChanged(date),
          ),
          const Divider(
            height: 80,
          ),
          CupertinoPickerRowOrganism(
            headers: Tab1InputLayout.scoreNames,
            labels: [
              Tab1InputLayout.labels,
              Tab1InputLayout.labels,
              Tab1InputLayout.labels
            ],
            onSelectedItemsChangedList: onPickerSelectionChangedList,
            pickerContainerColors: [
              AppColors.bgIndigo800,
              AppColors.bgIndigo600,
              AppColors.bgIndigo800,
            ],
            pickerHeight: 120,
            initialItemIndices: initialPickerItemsIndices,
          ),
          const Divider(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p_12,
            ),
            child: TitleWidgetRowMolecule(
              title: "Next Update Time",
              widget: TimeButtonAtom(
                initialTime: initialTime,
                onTimeChanged: (time) => onTimeChanged(time),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p_12,
            ),
            child: TextFormFieldAtom(
                initialValue: initialText,
                onChanged: (text) => onTextChanged(text),
                hintText: "Today's priority"),
          ),
          const SizedBox(height: 30),
          CancelSubmitRowMolecule(
              onCancelPressed: () => Navigator.of(context).pop(),
              onSubmitPressed: () => onSubmitPressed),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
