import 'package:flutter/material.dart';

final appDarkTheme = ThemeData(
  useMaterial3: true,

  // Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.indigo,
    // ···
    brightness: Brightness.dark,
  ),

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 25,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
    ),
    bodyMedium: TextStyle(fontSize: 15),
    bodySmall: TextStyle(fontSize: 12),
    labelSmall: TextStyle(fontSize: 8),
    labelMedium: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
  ),
);

// 10 minutes

class LaunchScreenColors {
  static const Color bgTimer = Colors.green;
  static const Color bgAlert = Colors.green;
  static Color bgInternal = Colors.indigo[900]!;
  static Color bgFMS = Colors.indigo[900]!;
  static const List<Color> bgFMSRadioButtons = [
    Colors.green,
    Colors.yellow,
    Colors.red
  ];
  static const Color bgExternalHeader = Colors.indigo;
  static const Color bgSeparator = Colors.black;
  static const Color bgTaskTodayTile = Colors.indigo;
  static const Color bgNonScheduledTile = Colors.indigo;
}

class SchedulingColors {
  static const Color? bgTodaysTasksHeader = null;
  static const Color? bgUpcomingTasksHeader = null;

  static Color bgTodaysTaskTile = Colors.indigo[800]!;
  static Color bgUpcomingTaskTile = Colors.indigo[800]!;
}

class Tab3Colors {
  static const Color? bgScheduledHeader = null;
  static const Color? bgNonScheduledHeader = null;
  static const Color? bgDateHeader = null;

  static const List<Color> bgPriorities = [
    Colors.purple,
    Colors.green,
    Colors.pink,
  ];

  static const Color bgDatePassed = Colors.orange;
}

class SPWPageColors {
  static const Color? bgSPWHeaderRow = null;

  static const Color bgDateCell = Colors.black;
  static const List<Color> bgSPWCells = [
    Colors.green,
    Colors.yellow,
    Colors.red
  ]; // Color is based on the score. 0 for green, 1 for yellow and 2 for red.
  static const Color bgWeightCell = Colors.black;
}

class AppColors {
  AppColors._();

  static const Color primary = Color.fromARGB(255, 251, 106, 2);
  static const Color secondary = Color.fromARGB(255, 108, 45, 244);

  static const Color bgGrey = Colors.grey;
  static const Color bgWhite = Colors.white;
  static const Color bgDark = Colors.black;

  // Red
  static Color bgRed300 = Colors.red[300]!;
  static Color bgRed400 = Colors.red[400]!;
  static Color bgRed500 = Colors.red[500]!;
  static Color bgRed600 = Colors.red[600]!;
  static Color bgRed700 = Colors.red[700]!;
  static Color bgRed800 = Colors.red[800]!;

  // Blue
  static Color bgBlue300 = Colors.blue[300]!;
  static Color bgBlue400 = Colors.blue[400]!;
  static Color bgBlue500 = Colors.blue[500]!;
  static Color bgBlue600 = Colors.blue[600]!;
  static Color bgBlue700 = Colors.blue[700]!;
  static Color bgBlue800 = Colors.blue[800]!;
  static const Color bgBlueTranslucent = Color.fromARGB(100, 33, 149, 243);

  // Indigo
  static Color bgIndigo300 = Colors.indigo[300]!;
  static Color bgIndigo400 = Colors.indigo[400]!;
  static Color bgIndigo500 = Colors.indigo[500]!;
  static Color bgIndigo600 = Colors.indigo[600]!;
  static Color bgIndigo700 = Colors.indigo[700]!;
  static Color bgIndigo800 = Colors.indigo[800]!;

  // Grayscale
  static const Color scale_00 = Color(0xFFFFFFFF);
  static const Color scale_01 = Color(0xFFF7F7F7);
  static const Color scale_02 = Color(0xFFE6E7E8);
  static const Color scale_03 = Color(0xFF747779);
  static const Color scale_04 = Color(0xFF808285);
  static const Color scale_05 = Color(0xFF454648);
  static const Color scale_06 = Color(0xFF292929);

  // Miscellaneous
  static const Color transparent = Colors.transparent;
  static const Color lightText = scale_00;
  static const Color bgTextFormField = scale_05;
}

class AppSizes {
  AppSizes._();

  static const double w_0 = 0.0;
  static const double h_4 = 4.0;
  static const double h_8 = 8.0;
  static const double h_12 = 12.0;
  static const double h_16 = 16.0;
  static const double h_20 = 20.0;
  static const double h_24 = 24.0;
  static const double h_28 = 28.0;
  static const double h_32 = 32.0;
  static const double h_36 = 36.0;
  static const double h_40 = 40.0;
  static const double h_44 = 44.0;
  static const double h_48 = 48.0;
  static const double h_52 = 42.0;
  static const double h_56 = 56.0;
  static const double h_60 = 60.0;
  static const double h_64 = 64.0;

  // Radiu
  static const double r_8 = 8.0;
  static const double r_16 = 16.0;
  static const double r_24 = 24.0;

  // Padding
  static const double p_8 = 8;
  static const double p_12 = 12;
  static const double p_16 = 16;
  static const double p_24 = 24;

  static Size mediaQuery(BuildContext context) => MediaQuery.of(context).size;
}

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
  static const TextStyle italicStyle =
      TextStyle(color: AppColors.bgWhite, fontStyle: FontStyle.italic);
}

// Typograpy.general
TextStyle timelyStyle = const TextStyle(fontSize: 20);

TextStyle h3TextStyle = const TextStyle(
  fontSize: 15,
);

// Tab Icons
Icon launchScreenIcon = const Icon(Icons.home);
Icon tabOneIcon = const Icon(Icons.looks_one_outlined);
Icon tabTwoIcon = const Icon(Icons.looks_two_outlined);
Icon tabThreeIcon = const Icon(Icons.looks_3_outlined);
Icon tabFourIcon = const Icon(Icons.looks_4_outlined);
Icon tabFiveIcon = const Icon(Icons.looks_5_outlined);
Icon tabSixIcon = const Icon(Icons.looks_6_outlined);
Icon tabSevenIcon = const Icon(Icons.pentagon);
Icon tabEightIcon = const Icon(Icons.pentagon);
Icon tabNineIcon = const Icon(Icons.pentagon);
Icon tabTenIcon = const Icon(Icons.pentagon);
Icon tabElevenIcon = const Icon(Icons.pentagon);
Icon tabTwelveIcon = const Icon(Icons.pentagon);

// Tab Colors
Color launchScreenColor = Colors.orange;
Color tabOneColor = Colors.deepPurpleAccent;
Color tabTwoColor = Colors.deepPurpleAccent;
Color tabThreeColor = Colors.deepPurpleAccent;
Color tabFourColor = Colors.deepPurpleAccent;
Color tabFiveColor = Colors.deepPurpleAccent;
Color tabSixColor = Colors.deepPurpleAccent;
Color tabSevenColor = Colors.deepPurpleAccent;
Color tabEightColor = Colors.deepPurpleAccent;
Color tabNineColor = Colors.deepPurpleAccent;
Color tabTenColor = Colors.deepPurpleAccent;
Color tabElevenColor = Colors.deepPurpleAccent;
Color tabTwelveColor = Colors.deepPurpleAccent;

// LaunchScreen Section Colors
Color launchSectionOneTimerColor = Colors.green;
Color launchSectionOneAlertColor = Colors.green;
Color launchSectionTwoColor = Colors.orange;
Color launchSectionThreeColor = Colors.blueGrey;
Color launchSectionFourColor = Colors.pinkAccent;

// LaunchScreen Text Colors
Color launchSectionOneTimerTextColor = Colors.white;
Color launchSectionOneAlertTextColor = Colors.white;
Color launchSectionTwoTextColor = Colors.black;
Color launchSectionThreeTextColor = Colors.white;
