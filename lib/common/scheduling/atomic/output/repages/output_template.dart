import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/common/atomic/molecules/rows/dismissible_entry_row_molecule.dart';
import 'package:timely/common/atomic/molecules/rows/navigation_row_molecule.dart';
import 'package:timely/common/scheduling/models/tab_2_model.dart';
import 'package:timely/tokens/app/app.dart';

class SchedulingOutputTemplate extends StatelessWidget {
  final Map<String, List<Tab2Model>> models;
  final Function(DismissDirection direction, Tab2Model model, String type)
      onDismissed;
  final Function(Tab2Model model) onTap;
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
        StatefulBuilder(
          builder: ((context, setState) {
            return ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Today's Tasks")],
                  ),
                ),
                ...List.generate(
                  models["today"]!.length,
                  (index) {
                    Tab2Model model = models["today"]![index];
                    return InkWell(
                      onTap: () => onTap(model),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(width: 0.5),
                          ),
                        ),
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
                          onDismissed: (direction) =>
                              onDismissed(direction, model, "today"),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Upcoming Tasks")],
                  ),
                ),
                ...List.generate(
                  models["upcoming"]!.length,
                  (index) {
                    Tab2Model model = models["upcoming"]![index];
                    return InkWell(
                      onTap: () => onTap(model),
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
                        onDismissed: (direction) =>
                            onDismissed(direction, model, "upcoming"),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
        ),
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
