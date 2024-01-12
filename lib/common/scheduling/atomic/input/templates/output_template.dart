import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/common/atomic/molecules/rows/dismissible_entry_row_molecule.dart';
import 'package:timely/common/atomic/molecules/rows/navigation_row_molecule.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/tokens/app/app.dart';

class SchedulingOutputTemplate extends StatelessWidget {
  final List<Tab2Model> models;
  final Function(DismissDirection direction, int index) onDismissed;
  final Function(int index) onTap;
  final VoidCallback onPressedHome;
  final VoidCallback onPressedAdd;

  final bool? showEndTime;

  const SchedulingOutputTemplate({
    super.key,
    required this.models,
    required this.onDismissed,
    required this.onTap,
    required this.onPressedHome,
    required this.onPressedAdd,
    required this.showEndTime,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StatefulBuilder(builder: ((context, setState) {
          return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(
              height: 0,
              thickness: 3,
              color: AppColors.bgDark,
            ),
            itemBuilder: (context, index) {
              Tab2Model model = models[index];

              return InkWell(
                onTap: () => onTap(index),
                child: DismissibleEntryRowMolecule(
                  child: TextRowMolecule(
                    customWidths: const {1: 50, 2: 50},
                    height: 60,
                    rowColor: AppColors.bgIndigo800,
                    defaultAligned: const [0],
                    texts: [
                      model.name!,
                      model.startTime.format(context),
                      model.getEndTime().format(context),
                    ],
                  ),
                  onDismissed: (direction) => onDismissed(direction, index),
                ),
              );
            },
            itemCount: models.length,
          );
        })),
        Column(
          children: [
            Expanded(
              child: Container(),
            ),
            NavigationRowMolecule(
              onPressedHome: () => onPressedHome(),
              onPressedAdd: () => onPressedAdd(),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        )
      ],
    );
  }
}
