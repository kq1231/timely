import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timely/tokens/app/app.dart';
import 'package:timely/common/atomic/atoms/atoms.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/common/atomic/organisms/organisms.dart';

import 'package:timely/modules/tab_1/controllers/input_controller.dart';

import 'package:timely/app_theme.dart';

class Tab1InputScreen extends ConsumerWidget {
  const Tab1InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab1InputProvider);
    final controller = ref.read(tab1InputProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DateButtonAtom.large(
              initialDate: provider.date,
              onDateChanged: (date) {
                controller.setDate(date);
              }),
          const Divider(
            height: 80,
          ),
          CupertinoPickerRowOrganism(
              headers: Tab1InputLayout.scoreNames,
              labels: Tab1InputLayout.labels,
              onSelectedItemChangedList: [
                (index) => controller.setFScore(index),
                (index) => controller.setMScore(index),
                (index) => controller.setSScore(index),
              ],
              pickerContainerColors: [
                AppColors.bgIndigo800,
                AppColors.bgIndigo600,
                AppColors.bgIndigo800,
              ],
              pickerHeight: 120,
              initialItemIndices: [
                provider.fScore,
                provider.mScore,
                provider.sScore
              ]),
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
                initialTime: provider.nextUpdateTime,
                onTimeChanged: (time) {
                  controller.setNextUpdateTime(time);
                },
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
                initialValue: provider.text_1,
                onChanged: (text) => controller.setText_1(text),
                hintText: "Today's priority"),
          ),
          const SizedBox(height: 30),
          CancelSubmitRowMolecule(
              onCancelPressed: () => Navigator.of(context).pop(),
              onSubmitPressed: () {
                controller.syncToDB();
                ref.invalidate(tab1InputProvider);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Submitted Successfully'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
