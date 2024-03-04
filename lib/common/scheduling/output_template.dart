import 'package:flutter/material.dart';
import 'package:timely/common/row_column_widgets.dart';
import 'package:timely/common/scheduling/tab_2_model.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/values.dart';

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
                Container(
                  color: SchedulingColors.bgTodaysTasksHeader,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Tab2Headings.todaysTasks,
                      )
                    ],
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
                            horizontal: BorderSide(width: 1),
                          ),
                        ),
                        child: Column(
                          children: [
                            DismissibleEntryRowMolecule(
                              child: TextRowMolecule(
                                customWidths: const {1: 50, 2: 50},
                                height: 60,
                                rowColor: SchedulingColors.bgTodaysTaskTile,
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
                            Container(
                              height: 40,
                              color: AppColors.bgIndigo800,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      model.getRepetitionSummary(),
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  color: SchedulingColors.bgUpcomingTasksHeader,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Tab2Headings.upcomingTasks,
                      ),
                    ],
                  ),
                ),
                ...List.generate(
                  models["upcoming"]!.length,
                  (index) {
                    Tab2Model model = models["upcoming"]![index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () => onTap(model),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border.symmetric(
                                horizontal: BorderSide(width: 1),
                              ),
                            ),
                            child: Column(
                              children: [
                                DismissibleEntryRowMolecule(
                                  child: TextRowMolecule(
                                    customWidths: const {1: 50, 2: 50},
                                    height: 60,
                                    rowColor:
                                        SchedulingColors.bgUpcomingTaskTile,
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
                                Container(
                                  height: 40,
                                  color: AppColors.bgIndigo800,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          model.getRepetitionSummary(),
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
