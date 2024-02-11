import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/rows/dismissible_entry_row_molecule.dart';

class ExternalEntriesTemplate extends StatefulWidget {
  final Color color;
  final Map<String, List> data;
  final Function(dynamic model, int tabNumber) onTap;
  final Function(DismissDirection direction, dynamic model, int tabNumber)
      onDismissed;

  const ExternalEntriesTemplate({
    super.key,
    required this.color,
    required this.data,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  State<ExternalEntriesTemplate> createState() =>
      _ExternalEntriesTemplateState();
}

class _ExternalEntriesTemplateState extends State<ExternalEntriesTemplate>
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
      for (var i = 0; i < widget.data["timed"]!.length; i++) {
        TimeOfDay time = widget.data["timed"]![i].last.last;
        if ("${time.hour}:${time.minute}" == currentTime) {
          setState(() {
            blinkIndices.add(i);
          });
          Future.delayed(const Duration(seconds: 30), () {
            setState(() {
              blinkIndices = [];
            });
          });
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
      child: widget.data["timed"]!.isEmpty
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Text("Default Text 2")),
              ],
            )
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                List models = widget.data["timed"]!;
                var model = models[index][1];
                var tabNumber = models[index][0];
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
                                      models[index].last[0],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      models[index].last[1].format(context),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: widget.data["timed"]!.length,
            ),
    );
  }
}
