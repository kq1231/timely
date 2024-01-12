import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/scheduling/atomic/input/templates/repeats_template.dart';
import 'package:timely/common/scheduling/atomic/input/templates/scheduling_input_template.dart';
import 'package:timely/common/scheduling/controllers/input_controller.dart';
import 'package:timely/tokens/app/app.dart';

class Tab2InputPage extends ConsumerWidget {
  final bool? showDurationSelector;
  const Tab2InputPage({
    super.key,
    this.showDurationSelector,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerOfTab2Model = ref.watch(tab2InputProvider);
    final controller = ref.read(tab2InputProvider.notifier);

    return SchedulingInputTemplate(
      showDurationSelector: true,
      onActivityChanged: (activity) => controller.setName(activity),
      onStartTimeChanged: (time) => controller.setStartTime(time),
      onHoursChanged: (hours) => controller.setDuration(
        Duration(hours: hours, minutes: providerOfTab2Model.dur.inMinutes % 60),
      ),
      onMinutesChanged: (minutes) => controller.setDuration(
        Duration(hours: providerOfTab2Model.dur.inHours, minutes: minutes),
      ),
      onRepeatsButtonPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Consumer(
              builder: (context, ref, child) {
                final localProv = ref.watch(tab2InputProvider);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.p_24),
                  child: RepeatsTemplate(
                    onBasisChanged: (basis) => controller.setBasis(basis),
                    onFrequencyChanged: (frequency) =>
                        controller.setFrequency(frequency),
                    onEveryChanged: (every) => controller.setEvery(every),
                    onEndDateChanged: (endDate) =>
                        controller.setEndDate(endDate),
                    onWeekdaySelectionsChanged: (selections) =>
                        controller.setWeeklyRepetitions(selections),
                    onMonthlySelectionsChanged: (selections) =>
                        controller.setMonthlyRepetitions(selections),
                    onOrdinalPositionChanged: (ordinalPosition) {
                      controller.setOrdinalPosition(ordinalPosition);
                    },
                    onWeekdayIndexChanged: (weekdayIndex) {
                      controller.setWeekdayIndex(weekdayIndex);
                    },
                    onYearlySelectionsChanged: (selections) {
                      controller.setYearlyRepetitions(selections);
                    },
                    model: localProv,
                  ),
                );
              },
            );
          },
        );
      },
      model: providerOfTab2Model,
      onSubmitButtonPressed: () {},
    );
  }
}
