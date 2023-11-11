import 'package:flutter/material.dart';

// Typograpy.general
TextStyle timelyStyle =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

TextStyle h3TextStyle = const TextStyle(
  fontSize: 15,
);

// Typography.TabOneOutputScreenA
TextStyle tabOneOutputScreenADateStyle = const TextStyle(fontSize: 20);
TextStyle tabOneOutputScreenATimeStyle = const TextStyle(fontSize: 14);

// Typography.TabOneOutputScreenB
TextStyle tabOneOutputScreenBCommentStyle = const TextStyle(fontSize: 12);

// Typography.TabOneOutputScreenC
TextStyle tabOneOutputScreenCCommentStyle = const TextStyle(fontSize: 12);

// Typography.TabFiveOutput
TextStyle tabFiveOutputTileTextStyle =
    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

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

// TabOneOutputScreenB Tile Colors
List<Color> outputScreenBAlternatingTileColors = [
  const Color.fromARGB(255, 90, 143, 236),
  Colors.blueGrey
];

// TabOneOutputScreenB Text Colors
List<Color> outputScreenBCommentTextColors = [Colors.black, Colors.white];

// TabOneOutputScreenC Tile Colors
List<Color> outputScreenCAlternatingTileColors = [Colors.grey, Colors.blueGrey];

// TabOneOutputScreenC Text Colors
List<Color> outputScreenCCommentTextColors = [Colors.black, Colors.white];

// TabOneOutputScreen Segmented Buttons Text
String tabOneOutputScreenSegButtonText_1 = "A";
String tabOneOutputScreenSegButtonText_2 = "B";
String tabOneOutputScreenSegButtonText_3 = "C";

// TabFiveAlternatingTileColors
List<Color> tabFiveAlternatingTileColors = [Colors.grey, Colors.blueGrey];

class TabOneOutputLayout {
  static List headers = ["Date", "F", "M", "S", "Time"];
  static TextStyle headerFont =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static List alternateColors = [
    Colors.blueGrey[800],
    Colors.grey[800],
  ];
  static TextStyle tileFont = const TextStyle(fontSize: 12);
}

class TabOneInputLayout {
  static List labels = ["Good", "Fair", "Poor"];
  static List scoreNames = ["F Score", "M Score", "S Score"];
  static String text_1Name = "Comment";
}
