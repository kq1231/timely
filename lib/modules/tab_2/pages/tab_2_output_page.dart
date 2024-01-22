import 'package:flutter/material.dart';
import 'package:timely/common/scheduling/atomic/output/repages/tab_2_output_page.dart';
import 'package:timely/modules/tab_2/controllers/output_controller.dart';
import 'package:timely/modules/tab_2/pages/tab_2_input_page.dart';

class Tab2OutputPage extends StatelessWidget {
  const Tab2OutputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SchedulingOutputRepage(
      providerOfTab2Models: tab2OutputProvider,
      inputPage: const Tab2InputPage(),
    );
  }
}
