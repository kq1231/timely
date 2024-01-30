import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timely/common/atomic/atoms/cupertino_picker/cupertino_picker_atom.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/tokens/app/app.dart';

class FMSTemplate extends StatefulWidget {
  final List<int> indices;
  final void Function(int index, int status) onStatusChanged;
  final Function(Timer timer, int status, int index) timerFunction;

  final FMSModel model;

  const FMSTemplate({
    super.key,
    required this.model,
    required this.indices,
    required this.timerFunction,
    required this.onStatusChanged,
  });

  @override
  State<FMSTemplate> createState() => _FMSTemplateState();
}

class _FMSTemplateState extends State<FMSTemplate> {
  late final Timer timer;

  @override
  void initState() {
    // Create three timers
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int i = 0;
      for (int status in widget.indices) {
        widget.timerFunction(timer, status, i);
        i++;
      }

      // If all three statuses are "Poor" then cancel the timer
      if (widget.indices.toSet().length == 1 &&
          widget.indices.toSet().first == 2) {
        timer.cancel();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    print("TIMER CANCELLED ON DISPOSE");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> texts = "Good,Fair,Poor".split(",");

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
                    title: stringifyDuration([
                      widget.model.fScore,
                      widget.model.mScore,
                      widget.model.sScore
                    ][i]),
                    widget: SizedBox(
                      child: AbsorbPointer(
                        absorbing: widget.indices[i] != 2 ? false : true,
                        child: CupertinoPickerAtom(
                          selectionOverlayColor: Colors.transparent,
                          horizontal: true,
                          itemExtent: 60,
                          onSelectedItemChanged: (status) =>
                              widget.onStatusChanged(i, status),
                          elements: texts,
                          initialItemIndex: widget.indices[i],
                          size: const Size(160, 80),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
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
