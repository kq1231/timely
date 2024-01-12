import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class TitleWidgetColumnMolecule extends StatelessWidget {
  final String title;
  final Widget widget;
  final double spacing;
  final bool? inverted;
  final bool? bolded;

  const TitleWidgetColumnMolecule({
    Key? key,
    required this.title,
    required this.widget,
    this.spacing = 20,
    this.inverted,
    this.bolded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Center(
        child: Text(
          title,
          style: bolded == true
              ? AppTypography.boldStyle
              : AppTypography.regularStyle,
        ),
      ),
      SizedBox(height: spacing),
      widget,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: inverted == null ? children : children.reversed.toList(),
    );
  }
}
