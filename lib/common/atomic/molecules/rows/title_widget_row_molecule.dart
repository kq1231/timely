import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class TitleWidgetRowMolecule extends StatelessWidget {
  final String title;
  final Widget widget;
  final bool? inverted;
  final bool? bolded;

  const TitleWidgetRowMolecule({
    super.key,
    required this.title,
    required this.widget,
    this.inverted,
    this.bolded,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        title,
        style: bolded == true
            ? AppTypography.boldStyle
            : AppTypography.regularStyle,
      ),
      const SizedBox(
        width: 20,
      ),
      widget,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: inverted == null ? children : children.reversed.toList(),
    );
  }
}
