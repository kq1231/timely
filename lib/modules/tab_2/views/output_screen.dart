import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:timely/exports/screens.dart';
import 'package:timely/modules/tab_2/controllers/output_controller.dart';

class Tab2OutputScreen extends StatelessWidget {
  const Tab2OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OutputScreen(
      tabOutputProvider: tab2OutputProvider,
      tabNumber: 2,
    );
  }
}
