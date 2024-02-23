import 'package:flutter/material.dart';
import 'package:timely/app_theme.dart';

class TextButtonAtom extends ElevatedButton {
  TextButtonAtom({
    super.key,
    required super.onPressed,
    required String text,
    Color? color,
  }) : super(
          child: Text(
            text,
            style: AppTypography.regularStyle,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.r_8),
            ),
          ),
        );
}
