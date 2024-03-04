import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timely/common/row_column_widgets.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';

class Tab1OutputTemplate extends StatelessWidget {
  final List<FMSModel> models;
  final VoidCallback onPressedHome;
  const Tab1OutputTemplate({
    super.key,
    required this.models,
    required this.onPressedHome,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          itemBuilder: (context, index) {
            FMSModel model = models[index];

            return TextRowMolecule(
              height: 40,
              rowColor: index % 2 == 0 ? Colors.indigo : Colors.indigoAccent,
              texts: [
                DateFormat(DateFormat.ABBR_MONTH_DAY).format(model.date),
                ...List.generate(
                    3,
                    (index) => stringifyDuration(
                        [model.fScore, model.mScore, model.sScore][index])),
              ],
              customWidths: const {0: 100},
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 2),
          itemCount: models.length,
        ),

        // Navigation Row
        Column(
          children: [
            const Spacer(),
            NavigationRowMolecule(
              onPressedHome: onPressedHome,
              hideAddButton: true,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}

String stringifyDuration(Duration duration) {
  return "${duration.inHours}:${duration.inMinutes % 60}:${duration.inSeconds % 60}";
}
