import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/rows/navigation_row_molecule.dart';
import 'package:timely/modules/tab_1_old/atomic/output/molecules/tab_1_header_row_molecule.dart';
import 'package:timely/modules/tab_1_old/atomic/output/organisms/tab_1_entry_list_organism.dart';
import 'package:timely/modules/tab_1_old/models/fms_model.dart';

class Tab1OutputTemplate extends StatelessWidget {
  final List<FMSModel> models;
  final VoidCallback onPressedHome;
  final VoidCallback onPressedAdd;
  final Function(DismissDirection direction, int index) onEntryDismissed;
  final Function(int index) onEntryTap;

  const Tab1OutputTemplate({
    super.key,
    required this.onPressedHome,
    required this.onPressedAdd,
    required this.onEntryDismissed,
    required this.onEntryTap,
    required this.models,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            const Tab1HeaderRowMolecule(),
            Tab1EntryListOrganism(
              models: models,
              onDismissed: (DismissDirection direction, index) =>
                  onEntryDismissed(direction, index),
              onTap: (index) => onEntryTap(index),
            ),
          ],
        ),
        Column(
          children: [
            Expanded(child: Container()),
            NavigationRowMolecule(
                onPressedHome: onPressedHome, onPressedAdd: onPressedAdd),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
