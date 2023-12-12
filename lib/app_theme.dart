import 'package:flutter/material.dart';

// Typograpy.general
TextStyle timelyStyle = const TextStyle(fontSize: 20);

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

class Tab1OutputLayout {
  static List headers = ["Date", "F", "M", "S", "Time"];
  static TextStyle headerFont =
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static List alternateColors = [
    Colors.blueGrey[800],
    Colors.grey[800],
  ];
  static TextStyle tileFont = const TextStyle(fontSize: 12);
}

class Tab1InputLayout {
  static List labels = ["Good", "Fair", "Poor"];
  static List scoreNames = ["F Score", "M Score", "S Score"];
  static String text_1Name = "Comment";
}

class Tab3InputLayout {
  static List labels = ["High", "Medium", "Low"];
  static String dateButtonText = "Date";
  static String timeButtonText = "Time";
  static String cancelButtonText = "Cancel";
  static String submitButtonText = "Submit";
  static String submissionStatusMessage = "Submitted Successfully";

  // Typography
  static TextStyle cancelButtonStyle = const TextStyle();
  static TextStyle submitButtonStyle = const TextStyle();
  static TextStyle submissionStatusMessageStyle = const TextStyle();
  static TextStyle timeButtonStyle = const TextStyle();
  static TextStyle dateButtonStyle = const TextStyle();
  static TextStyle labelsStyle = const TextStyle();
}

class Tab3OutputLayout {
  static List<Color> rowColors = [Colors.purple, Colors.green, Colors.pink];

  // Typography
  static TextStyle dateStyle = const TextStyle();
  static TextStyle timeStyle = const TextStyle();
  static TextStyle text_1Style = const TextStyle();
}

class Tab4OutputLayout {
  // Typography
  static TextStyle numberStyle = const TextStyle();
  static TextStyle text_1Style = const TextStyle();
}

class Tab5InputLayout {
  static List<String> labels = ["Good", "Fair", "Poor"];
  static List scoreNames = ["S Score", "P Score", "W Score"];
  static String weightFieldName = "Weight";
  static String cancelButtonText = "Cancel";
  static String submitButtonText = "Submit";
  static String submissionStatusMessage = "Submitted Successfully";

  // Typography
  static TextStyle dateStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle scoreNamesStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle labelStyle = const TextStyle();
  static TextStyle weightFieldStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle cancelButtonStyle = const TextStyle();
  static TextStyle submitButtonStyle = const TextStyle();
  static TextStyle submissionStatusMessageStyle = const TextStyle();
}

class Tab5OutputLayout {
  static List spacings = [70.0, 70.0, 20.0];
  static List headers = ["Date", "S", "P", "W", "Weight"];
  static List alternatingColors = [
    Colors.blueGrey[800],
    Colors.grey[800],
  ];

  // Typography
  static TextStyle tabFiveOutputTileTextStyle = const TextStyle(fontSize: 13);
}

class LaunchScreenLayout {
  static List colors = [Colors.purple, Colors.green, Colors.pink];

  // Typography
  static TextStyle timeStyle =
      TextStyle(fontSize: 15, color: launchSectionOneTimerTextColor);
  static TextStyle alertStyle =
      TextStyle(fontSize: 15, color: launchSectionOneAlertTextColor);
  static TextStyle tab1TextStyle = TextStyle(
    color: launchSectionTwoTextColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static TextStyle tab3TextStyle = const TextStyle(fontSize: 15);
  static TextStyle tab4TextStyle =
      TextStyle(fontSize: 15, color: launchSectionThreeTextColor);
}

class Tab2InputLayout {
  // Constants
  static String text1ButtonText = "Text 1";
  static List<DropdownMenuItem> repeatDropdownButtonItems = [
    const DropdownMenuItem(
      value: "Daily",
      child: Text("Daily"),
    ),
    const DropdownMenuItem(
      value: "Weekly",
      child: Text("Weekly"),
    ),
    const DropdownMenuItem(
      value: "Yearly",
      child: Text("Yearly"),
    ),
    const DropdownMenuItem(
      value: "Monthly",
      child: Text("Monthly"),
    ),
  ];
  static List<DropdownMenuItem> endRepeatDropdownButtonItems = [
    const DropdownMenuItem(
      value: "Never",
      child: Text("Never"),
    ),
  ];
  static String repeatText = "Repeat";
  static String endRepeatText = "End Repeat";
}
