import 'package:flutter/material.dart';
import 'package:timely/app_theme.dart';

class ScoreRowMolecule extends StatelessWidget {
  final String title;
  final String time;
  final int status;
  final double height;
  final List<double> sizes;
  final bool locked;
  final TextStyle? textStyle;
  final void Function(int status) onStatusChanged;

  const ScoreRowMolecule({
    super.key,
    required this.title,
    required this.time,
    required this.status,
    required this.onStatusChanged,
    required this.sizes,
    required this.height,
    required this.locked,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    const List<Color> colors = LaunchScreenColors.bgFMSRadioButtons;

    return SizedBox(
      height: height,
      child: Row(
        children: [
          SizedBox(
            width: sizes[0],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(title),
            ),
          ),
          Expanded(
            child: Center(child: Text(time)),
          ),
          AbsorbPointer(
            absorbing: locked,
            child: Row(
              children: [
                ...List.generate(3, (index) {
                  return SizedBox(
                    width: sizes[2],
                    child: Center(
                      child: Transform.scale(
                        scale: 1.2,
                        child: Radio(
                          activeColor: colors[index],
                          value: status,
                          groupValue: index,
                          onChanged: (_) => onStatusChanged(index),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
