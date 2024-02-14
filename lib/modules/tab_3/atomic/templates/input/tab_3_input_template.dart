import 'package:flutter/material.dart';
import 'package:timely/common/atomic/atoms/buttons/date_button_atom.dart';
import 'package:timely/common/atomic/atoms/buttons/time_button_atom.dart';
import 'package:timely/common/atomic/atoms/cupertino_picker/cupertino_picker_atom.dart';
import 'package:timely/common/atomic/atoms/text/text_form_field_atom.dart';
import 'package:timely/common/atomic/molecules/rows/cancel_submit_row_molecule.dart';
import 'package:timely/common/atomic/molecules/rows/title_widget_row_molecule.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/tokens/app/app.dart';
import 'package:timely/tokens/headings.dart';

class Tab3InputTemplate extends StatelessWidget {
  final Tab3Model model;
  final Function(String activity) onActivityChanged;
  final Function(DateTime date) onDateChanged;
  final Function(TimeOfDay time) onTimeChanged;
  final Function(int index) onPriorityChanged;
  final VoidCallback onSubmitPressed;
  final VoidCallback onCancelPressed;
  final Function(bool value) onScheduleChanged;

  const Tab3InputTemplate({
    super.key,
    required this.model,
    required this.onActivityChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onPriorityChanged,
    required this.onSubmitPressed,
    required this.onCancelPressed,
    required this.onScheduleChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool scheduled = (model.date == null && model.time == null) ? false : true;

    List<Widget> children = [
      const SizedBox(
        height: 40,
      ),

      // Activity Text Field
      TextFormFieldAtom(
        initialValue: model.text_1,
        onChanged: onActivityChanged,
        hintText: Tab3Headings.activity,
      ),

      // "Scheduled" Switch
      Column(
        children: [
          TitleWidgetRowMolecule(
            title: Tab3Headings.scheduled,
            widget: Switch(
              value: scheduled,
              onChanged: (value) {
                onScheduleChanged(value);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),

      // Date Button
      scheduled != false
          ? Column(
              children: [
                TitleWidgetRowMolecule(
                  title: Tab3Headings.date,
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
                  title: Tab3Headings.time,
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
        title: Tab3Headings.priority,
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
