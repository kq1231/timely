import 'package:flutter/material.dart';
import 'package:timely/modules/tab_1/views/score_row_molecule.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/values.dart';

class FMSTemplate extends StatefulWidget {
  final void Function(int index) onTap;

  final FMSModel model;

  const FMSTemplate({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  State<FMSTemplate> createState() => _FMSTemplateState();
}

class _FMSTemplateState extends State<FMSTemplate> {
  List<int> statuses = [];
  List<Duration> scores = [];
  List<DateTime?> times = [];
  List<String> labels = LaunchScreenHeadings.labels;

  @override
  Widget build(BuildContext context) {
    statuses = [
      widget.model.mStatus,
      widget.model.fStatus,
      widget.model.sStatus
    ];
    scores = [
      widget.model.mScore,
      widget.model.fScore,
      widget.model.sScore,
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(Tab1Headings.items),
              Expanded(child: Container()),
              Text(Tab1Headings.time)
            ],
          ),
        ),
        ...List.generate(3, (index) {
          return Expanded(
            child: ScoreRowMolecule(
              onTap: () => widget.onTap(index),
              height: 50,
              title: [
                Tab1Headings.mScore,
                Tab1Headings.fScore,
                Tab1Headings.sScore
              ][index],
              time: stringifyDuration(
                scores[index],
              ),
              sizes: const [
                80,
                100,
                50,
              ],
            ),
          );
        }),
      ],
    );
  }
}

String stringifyDuration(Duration duration) {
  return "${duration.inHours}:${duration.inMinutes % 60}:${duration.inSeconds % 60}";
}
