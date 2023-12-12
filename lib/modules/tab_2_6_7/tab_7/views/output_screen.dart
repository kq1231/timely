import 'package:flutter/widgets.dart';
import 'package:timely/exports/screens.dart';
import 'package:timely/modules/tab_2_6_7/tab_7/controllers/output_controller.dart';

class Tab7OutputScreen extends StatelessWidget {
  const Tab7OutputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OutputScreen(
      tabOutputProvider: tab7OutputProvider,
      showEndTime: false,
    );
  }
}
