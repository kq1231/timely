import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class TimeButtonAtom extends StatelessWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay time) onTimeChanged;
  final Size buttonSize;

  const TimeButtonAtom({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    this.buttonSize = const Size(120, 30),
  });
  const TimeButtonAtom.large({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    this.buttonSize = const Size(170, 50),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize.width,
      height: buttonSize.height,
      child: ElevatedButton(
        onPressed: () async {
          TimeOfDay? timeSelected =
              await showTimePicker(context: context, initialTime: initialTime);
          if (timeSelected != null) {
            onTimeChanged(timeSelected);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bgIndigo700,
          foregroundColor: AppColors.bgWhite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSizes.r_8,
              ),
            ),
          ),
        ),
        child: Text(
          initialTime.format(context),
        ),
      ),
    );
  }
}
