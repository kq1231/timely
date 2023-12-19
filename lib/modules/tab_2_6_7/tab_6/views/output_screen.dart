import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timely/exports/screens.dart';
import 'package:timely/modules/tab_2_6_7/tab_6/controllers/output_controller.dart';

class Tab6OutputScreen extends StatelessWidget {
  const Tab6OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OutputScreen(
      tabOutputProvider: tab6OutputProvider,
      tabNumber: 6,
      showEndTime: false,
    );
  }
}
