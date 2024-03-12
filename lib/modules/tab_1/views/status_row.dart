import 'package:flutter/material.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/values.dart';

class StatusRowMolecule extends StatelessWidget {
  final int status;
  final bool locked;
  final void Function(int status) onStatusChanged;

  const StatusRowMolecule({
    super.key,
    required this.status,
    required this.onStatusChanged,
    required this.locked,
  });

  @override
  Widget build(BuildContext context) {
    const List<Color> colors = LaunchScreenColors.bgFMSRadioButtons;

    return AbsorbPointer(
      absorbing: locked,
      child: Row(
        children: [
          ...List.generate(3, (index) {
            return Column(
              children: [
                Text([
                  Tab1Headings.start,
                  Tab1Headings.pause,
                  Tab1Headings.stop,
                ][index]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
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
                  ),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
