import 'package:flutter/material.dart';
import 'package:timely/common/atomic/atoms/buttons/date_button_atom.dart';
import 'package:timely/common/atomic/atoms/buttons/time_button_atom.dart';
import 'package:timely/common/atomic/atoms/cupertino_picker/cupertino_picker_atom.dart';
import 'package:timely/common/atomic/atoms/text/text_form_field_atom.dart';
import 'package:timely/common/atomic/molecules/rows/cancel_submit_row_molecule.dart';
import 'package:timely/common/atomic/molecules/rows/title_widget_row_molecule.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/tokens/app/app.dart';

class Tab3InputTemplate extends StatelessWidget {
  final Tab3Model model;
  final Function(String activity) onActivityChanged;
  final Function(DateTime date) onDateChanged;
  final Function(TimeOfDay time) onTimeChanged;
  final Function(int index) onPriorityChanged;
  final VoidCallback onSubmitPressed;
  final VoidCallback onCancelPressed;
  final bool? removeDateTime;

  const Tab3InputTemplate({
    super.key,
    required this.model,
    required this.onActivityChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onPriorityChanged,
    required this.onSubmitPressed,
    required this.onCancelPressed,
    this.removeDateTime,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      const SizedBox(
        height: 40,
      ),

      // Activity Text Field
      TextFormFieldAtom(
        initialValue: model.text_1,
        onChanged: onActivityChanged,
        hintText: "Activity",
      ),

      // Date Button
      removeDateTime != true
          ? Column(
              children: [
                TitleWidgetRowMolecule(
                  title: "Date",
                  widget: DateButtonAtom.large(
                    initialDate: model.date ?? DateTime.now(),
                    onDateChanged: onDateChanged,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                // Time Button
                TitleWidgetRowMolecule(
                  title: "Time",
                  widget: TimeButtonAtom.large(
                    initialTime: model.time ?? TimeOfDay.now(),
                    onTimeChanged: onTimeChanged,
                  ),
                ),
              ],
            )
          : Container(),

      // Priority Picker
      TitleWidgetRowMolecule(
        title: "Priority",
        widget: CupertinoPickerAtom(
          itemExtent: 60,
          onSelectedItemChanged: onPriorityChanged,
          elements: "High,Medium,Low".split(","),
          initialItemIndex: model.priority,
          size: const Size(150, 120),
        ),
      ),

      // Cancel & Submit Row
      CancelSubmitRowMolecule(
        onSubmitPressed: onSubmitPressed,
        onCancelPressed: onCancelPressed,
      ),

      const SizedBox(
        height: 40,
      ),
    ];
    return ListView.separated(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: index != children.length - 2 ? AppSizes.p_16 : 0,
        ),
        child: children[index],
      ),
      separatorBuilder: (context, index) =>
          [0, 2, children.length - 2].contains(index)
              ? Container()
              : const Divider(height: 40),
      itemCount: children.length,
    );
  }
}
