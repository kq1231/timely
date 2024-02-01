import 'package:flutter/material.dart';
import 'package:timely/common/atomic/atoms/cupertino_picker/cupertino_picker_atom.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/tokens/app/app.dart';

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
  List<FixedExtentScrollController> scrollControllers = [];
  List<int> statuses = [];
  List<String> texts = "Good,Fair,Poor".split(",");

  @override
  void initState() {
    super.initState();

    statuses = [
      widget.model.fStatus,
      widget.model.mStatus,
      widget.model.sStatus
    ];

    scrollControllers = [
      FixedExtentScrollController(initialItem: statuses[0]),
      FixedExtentScrollController(initialItem: statuses[1]),
      FixedExtentScrollController(initialItem: statuses[2]),
    ];

    for (var i = 0; i < scrollControllers.length; i++) {
      scrollControllers[i].addListener(() => _onScroll(i));
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var scrollController in scrollControllers) {
      scrollController.removeListener(() {});
    }
  }

  void _onScroll(int i) async {
    await Future.delayed(const Duration(milliseconds: 10));

    if (scrollControllers[i].position.isScrollingNotifier.value == false) {
      int currentItemIndex = scrollControllers[i].selectedItem;
      if (statuses[i] != currentItemIndex) {
        _showDialog(currentItemIndex, currentItemIndex);
      }
    }
  }

  void _showDialog(int index, int status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('You have selected item ${texts[index]}. Confirm?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                widget.onStatusChanged(index, status);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    statuses = [
      widget.model.fStatus,
      widget.model.mStatus,
      widget.model.sStatus
    ];

    return ListView(
      shrinkWrap: true,
      children: [
        ...List.generate(
          3,
          (i) {
            return Column(
              children: [
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.p_16,
                  ),
                  child: TitleWidgetRowMolecule(
                    title: "${"FMS"[i]}      ${stringifyDuration([
                      widget.model.fScore,
                      widget.model.mScore,
                      widget.model.sScore
                    ][i])}",
                    widget: SizedBox(
                      child: AbsorbPointer(
                        absorbing: isLocked(
                          status: statuses[i],
                          time: statuses[i] == 1
                              ? [
                                  widget.model.fPauseTime,
                                  widget.model.mPauseTime,
                                  widget.model.sPauseTime
                                ][i]
                              : null,
                        ),
                        child: CupertinoPickerAtom(
                          selectionOverlayColor: Colors.transparent,
                          scrollController: scrollControllers[i],
                          horizontal: true,
                          itemExtent: 60,
                          onSelectedItemChanged: (status) {},
                          elements: texts,
                          initialItemIndex: statuses[i],
                          size: const Size(160, 80),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

String stringifyDuration(Duration duration) {
  return "${duration.inHours}:${duration.inMinutes % 60}:${duration.inSeconds % 60}";
}

bool isLocked({required int status, DateTime? time}) {
  if (status == 2) // Yani status is "Poor"
  {
    return true;
  } else if (status == 1) // Yani status is "Fair"
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
