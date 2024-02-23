import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';

class DateButtonAtom extends StatelessWidget {
  final DateTime? initialDate;
  final Function(DateTime date) onDateChanged;
  final Size buttonSize;
  final String? defaultText;

  const DateButtonAtom({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
    this.buttonSize = const Size(70, 20),
    this.defaultText,
  });
  const DateButtonAtom.large({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
    this.buttonSize = const Size(170, 50),
    this.defaultText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize.width,
      height: buttonSize.height,
      child: ElevatedButton(
        onPressed: () async {
          var dateSelected = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: DateTime(0),
            lastDate: DateTime(DateTime.now().year + 50),
          );
          if (dateSelected != null) {
            onDateChanged(dateSelected);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bgBlue600,
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
          initialDate != null
              ? DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(initialDate!)
              : defaultText ?? "",
        ),
      ),
    );
  }
}
