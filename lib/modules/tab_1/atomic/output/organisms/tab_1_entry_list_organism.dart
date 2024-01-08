import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timely/common/atomic/molecules/rows/dismissible_entry_row_molecule.dart';
import 'package:timely/common/atomic/molecules/rows/text_row_molecule.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/tokens/tab_1_colors.dart';

class Tab1EntryListOrganism extends StatefulWidget {
  final List<FMSModel> models;
  final Function(DismissDirection direction, int index) onDismissed;
  final Function(int index) onTap;

  const Tab1EntryListOrganism(
      {super.key,
      required this.models,
      required this.onDismissed,
      required this.onTap});

  @override
  State<Tab1EntryListOrganism> createState() => _Tab1EntryListOrganismState();
}

class _Tab1EntryListOrganismState extends State<Tab1EntryListOrganism> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        FMSModel model = widget.models[index];
        List colors = [Tab1Colors.good, Tab1Colors.fair, Tab1Colors.poor];

        return InkWell(
          onTap: () => widget.onTap(index),
          child: DismissibleEntryRowMolecule(
            onDismissed: (direction) => widget.onDismissed(direction, index),
            child: TextRowMolecule(
              colors: {
                0: Tab1Colors.alternateColors[index % 2],
                1: colors[model.fScore],
                2: colors[model.mScore],
                3: colors[model.sScore],
              },
              customWidths: const {0: 70},
              texts: [
                DateFormat(DateFormat.ABBR_MONTH_DAY)
                    .format(model.date)
                    .toString(),
                model.fScore.toString(),
                model.mScore.toString(),
                model.sScore.toString(),
              ],
            ),
          ),
        );
      },
      itemCount: widget.models.length,
    );
  }
}
