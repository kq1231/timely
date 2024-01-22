import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/rows/dismissible_entry_row_molecule.dart';
import 'package:timely/common/atomic/molecules/rows/navigation_row_molecule.dart';
import 'package:timely/common/atomic/molecules/rows/text_row_molecule.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/tokens/tab_3_colors.dart';

class Tab4OutputTemplate extends StatelessWidget {
  final List<Tab3Model> models;
  final Function(DismissDirection direction, int index) onDismissed;
  final Function(int index) onTap;
  final VoidCallback onPressedHome;
  final VoidCallback onPressedAdd;

  const Tab4OutputTemplate({
    super.key,
    required this.models,
    required this.onDismissed,
    required this.onTap,
    required this.onPressedHome,
    required this.onPressedAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () => onTap(index),
                  child: DismissibleEntryRowMolecule(
                    onDismissed: (direction) => onDismissed(direction, index),
                    child: TextRowMolecule(
                      minHeight: 60,
                      rowColor: Tab3OutputColors
                          .priorityColors[models[index].priority],
                      texts: [
                        (index + 1).toString(),
                        models[index].text_1,
                      ],
                      customWidths: const {
                        0: 80,
                      },
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: models.length,
        ),
        Column(
          children: [
            Expanded(
              child: Container(),
            ),
            NavigationRowMolecule(
              onPressedHome: onPressedHome,
              onPressedAdd: onPressedAdd,
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
