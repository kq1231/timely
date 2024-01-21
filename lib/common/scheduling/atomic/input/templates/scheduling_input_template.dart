import 'package:flutter/material.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/tokens/app/app_sizes.dart';
import 'package:timely/tokens/app/app_typography.dart';

import '../../../../atomic/atoms/atoms.dart';
import '../../../../atomic/molecules/molecules.dart';
import '../molecules/duration_selection_molecule.dart';

class SchedulingInputTemplate extends StatelessWidget {
  final bool? showDurationSelector;

  final Tab2Model model;
  final Function(String activity) onActivityChanged;
  final Function(TimeOfDay time) onStartTimeChanged;
  final Function(int hours) onHoursChanged;
  final Function(int minutes) onMinutesChanged;
  final VoidCallback onRepeatsButtonPressed;
  final VoidCallback onSubmitButtonPressed;

  const SchedulingInputTemplate(
      {super.key,
      this.showDurationSelector,
      required this.onActivityChanged,
      required this.onStartTimeChanged,
      required this.onHoursChanged,
      required this.onMinutesChanged,
      required this.onRepeatsButtonPressed,
      required this.model,
      required this.onSubmitButtonPressed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 40,
        ), // Some empty space at the top below the appbar.
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_16),
            child: TextFormFieldAtom(
              initialValue: model.name,
              onChanged: (activity) => onActivityChanged(activity),
              hintText: "Activity",
            ),
          ),
        ),
        const Divider(height: 30),
        Column(
          children: [
            // Repeat button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_24),
              child: TitleWidgetRowMolecule(
                title: "Time",
                widget: TimeButtonAtom(
                    initialTime: model.startTime,
                    onTimeChanged: (time) => onStartTimeChanged(time)),
              ),
            ),
            const Divider(height: 30),
            // End repeat
            const SizedBox(
              height: 10,
            ),
            showDurationSelector == false
                ? Container()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p_24),
                        child: TitleWidgetRowMolecule(
                          title: "Duration",
                          widget: Expanded(
                            child: DurationSelectionMolecule(
                              onHoursChanged: (int hours) =>
                                  onHoursChanged(hours),
                              onMinutesChanged: (int minutes) =>
                                  onMinutesChanged(minutes),
                              initalHourIndex: model.dur.inHours,
                              initalMinuteIndex: model.dur.inMinutes % 60,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 40,
                      ),
                    ],
                  ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.p_24),
              child: TitleWidgetRowMolecule(
                title: "Repeats",
                widget: TextButtonAtom(
                  text: "Daily",
                  onPressed: () => onRepeatsButtonPressed(),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.p_8),
                child: Text(
                  model.getRepetitionSummary(),
                  style: AppTypography.italicStyle,
                ),
              ),
            ),
            const Divider(
              height: 30,
            ),

            CancelSubmitRowMolecule(
              onCancelPressed: () => Navigator.pop(context),
              onSubmitPressed: () => onSubmitButtonPressed(),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
