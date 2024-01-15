import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class TextRowMolecule extends StatelessWidget {
  final List<String> texts;
  final Color? rowColor;
  final List<int> defaultAligned;
  final Map<int, double> customWidths;
  final Map<int, Color> colors; // New addition for custom colors
  final bool? bolded;
  final double? height;
  final double? minHeight;

  const TextRowMolecule({
    Key? key,
    required this.texts,
    this.customWidths = const {},
    this.colors = const {}, // Initialize with an empty map
    this.bolded,
    this.height,
    this.rowColor,
    this.defaultAligned = const [],
    this.minHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight ?? 0.0,
      ),
      child: Container(
        color: rowColor,
        child: Row(
          children: List.generate(texts.length, (index) {
            return customWidths.containsKey(index)
                ? Container(
                    color: colors.containsKey(index) ? colors[index] : null,
                    child: SizedBox(
                      width: customWidths[index],
                      child: defaultAligned.contains(index)
                          ? Row(
                              children: [
                                Text(
                                  texts[index],
                                  style: bolded == true
                                      ? AppTypography.boldStyle
                                      : AppTypography.regularStyle,
                                ),
                              ],
                            )
                          : Center(
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
                      child: defaultAligned.contains(index)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      texts[index],
                                      style: bolded == true
                                          ? AppTypography.boldStyle
                                          : AppTypography.regularStyle,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
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
        ),
      ),
    );
  }
}
