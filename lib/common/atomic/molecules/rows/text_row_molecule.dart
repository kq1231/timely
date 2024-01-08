import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class TextRowMolecule extends StatelessWidget {
  final List<String> texts;
  final Map<int, double> customWidths;
  final Map<int, Color> colors; // New addition for custom colors
  final bool? bolded;
  final double height;

  const TextRowMolecule({
    Key? key,
    required this.texts,
    this.customWidths = const {},
    this.colors = const {}, // Initialize with an empty map
    this.bolded,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(texts.length, (index) {
        return customWidths.containsKey(index)
            ? Container(
                height: height,
                color: colors.containsKey(index) ? colors[index] : null,
                child: SizedBox(
                  width: customWidths[index],
                  child: Center(
                    child: Text(
                      texts[index],
                      style: bolded == true
                          ? AppTypography.boldStyle
                          : AppTypography.regularStyle,
                    ),
                  ),
                ),
              )
            : Expanded(
                child: Container(
                  height: height,
                  color: colors.containsKey(index) ? colors[index] : null,
                  child: Center(
                    child: Text(
                      texts[index],
                      style: bolded == true
                          ? AppTypography.boldStyle
                          : AppTypography.regularStyle,
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
