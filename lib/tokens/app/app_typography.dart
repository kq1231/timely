import 'package:flutter/material.dart';
import 'package:timely/tokens/app/app.dart';

class AppTypography {
  AppTypography._();

  // Font Sizes
  static const double sizeXXS = 8;
  static const double sizeXS = 13;
  static const double sizeSM = 21;
  static const double sizeSL = 28;
  static const double sizeMD = 34;
  static const double sizeLG = 40;
  static const double sizeXL = 48;
  static const double sizeXXL = 55;

  // Styles
  static const TextStyle regularStyle = TextStyle(color: AppColors.bgWhite);
  static const TextStyle boldStyle =
      TextStyle(color: AppColors.bgWhite, fontWeight: FontWeight.bold);
}
