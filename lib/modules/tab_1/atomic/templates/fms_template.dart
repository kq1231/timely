import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/modules/tab_1/atomic/molecules/score_row_molecule.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/values.dart';

class FMSTemplate extends StatefulWidget {
  final void Function(int index, int status) onStatusChanged;

  final FMSModel model;

  const FMSTemplate({
    super.key,
    required this.model,
    required this.onStatusChanged,
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
    times = [
      widget.model.mPauseTime,
      widget.model.fPauseTime,
      widget.model.sPauseTime
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextRowMolecule(
            height: 40,
            texts: [Tab1Headings.items, Tab1Headings.time, Tab1Headings.status],
            bolded: true,
            customWidths: const {0: 80, 2: 150},
            defaultAligned: const [0],
          ),
        ),
        TextRowMolecule(
          texts: [
            "",
            "",
            Tab1Headings.start,
            Tab1Headings.pause,
            Tab1Headings.stop
          ],
          customWidths: const {2: 50, 3: 50, 4: 50},
          textStyle: const TextStyle(fontSize: 10),
        ),
        ...List.generate(3, (index) {
          return Expanded(
            child: ScoreRowMolecule(
              locked: isLocked(status: statuses[index], time: times[index]),
              height: 50,
              title: [
                Tab1Headings.mScore,
                Tab1Headings.fScore,
                Tab1Headings.sScore
              ][index],
              time: stringifyDuration(
                scores[index],
              ),
              status: statuses[index],
              onStatusChanged: (status) {
                widget.onStatusChanged(index, status);
              },
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

bool isLocked({required int status, DateTime? time}) {
  if (status == 2) // Yani status is "Pause"
  {
    return true;
  } else if (status == 1) // Yani status is "Stop"
  {
    // Check if the time elapsed is half-an-hour or more
    if ((DateTime.now().difference(time!).inSeconds / 60) >= 30) {
      return false; // Yani it is unlocked
    } else {
      return true;
    }
  } else {
    return false;
  }
}
