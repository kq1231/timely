import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/rows/dismissible_entry_row_molecule.dart';
import 'package:timely/modules/home/models/task_today.dart';

class TasksTodayTemplate extends StatefulWidget {
  final Color color;
  final List<TaskToday> data;
  final Function(dynamic model, int tabNumber) onTap;
  final Function(DismissDirection direction, dynamic model, int tabNumber)
      onDismissed;

  const TasksTodayTemplate({
    super.key,
    required this.color,
    required this.data,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  State<TasksTodayTemplate> createState() => _TasksTodayTemplateState();
}

class _TasksTodayTemplateState extends State<TasksTodayTemplate>
    with SingleTickerProviderStateMixin {
  List blinkIndices = [];
  late AnimationController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..repeat(
        reverse: true,
      );
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      var now = DateTime.now();
      var currentTime = "${now.hour}:${now.minute}";
      for (var i = 0; i < widget.data.length; i++) {
        TimeOfDay time = widget.data[i].startTime;
        if ("${time.hour}:${time.minute}" == currentTime) {
          setState(() {
            blinkIndices.add(i);
          });
          Future.delayed(const Duration(seconds: 30), () {
            setState(() {
              blinkIndices = [];
            });
          });
          break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: widget.data.isEmpty
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text("Default Text 2")),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var model = widget.data[index].model;
                var tabNumber = widget.data[index].tabNumber;
                return InkWell(
                  onTap: () => widget.onTap(model, tabNumber),
                  child: DismissibleEntryRowMolecule(
                    onDismissed: (direction) =>
                        widget.onDismissed(direction, model, tabNumber),
                    child: Column(
                      children: [
                        const Divider(
                          height: 0.2,
                        ),
                        Container(
                          color: Colors.indigo[700],
                          child: FadeTransition(
                            opacity: blinkIndices.contains(index)
                                ? _controller
                                : const AlwaysStoppedAnimation(1.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.data[index].name,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      widget.data[index].startTime
                                          .format(context),
                                    ),
                                  ),
                                ),
                                widget.data[index].endTime != null
                                    ? SizedBox(
                                        width: 50,
                                        child: Text(
                                          widget.data[index].endTime!
                                              .format(context),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: widget.data.length,
            ),
    );
  }
}
