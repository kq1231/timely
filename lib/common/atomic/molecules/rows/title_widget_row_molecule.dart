import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class TitleWidgetRowMolecule extends StatelessWidget {
  final String title;
  final Widget widget;

  const TitleWidgetRowMolecule({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTypography.regularStyle),
        widget,
      ],
    );
  }
}
