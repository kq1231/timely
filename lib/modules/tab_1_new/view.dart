import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1_new/model_provider.dart';

class ProgressView extends ConsumerStatefulWidget {
  const ProgressView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProgressViewState();
}

class _ProgressViewState extends ConsumerState<ProgressView> {
  Duration _remainingTime = Duration.zero;
  Duration _elapsedTime = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _startTimerIfWithinRange();
  }

  void _startTimerIfWithinRange() {
    final now = DateTime.now();
    final tenPM = DateTime(now.year, now.month, now.day, 22, 0);
    final sixAM = DateTime(now.year, now.month, now.day, 6, 0);

    if (now.isAfter(sixAM) && now.isBefore(tenPM)) {
      _timer = Timer.periodic(
          const Duration(seconds: 1),
          (_) => setState(() {
                _updateTime();
              }));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    final tenPM = DateTime(now.year, now.month, now.day, 22, 0);
    final sixAM = DateTime(now.year, now.month, now.day, 6, 0);

    if (now.isBefore(tenPM)) {
      _remainingTime = tenPM.difference(now);
      _elapsedTime = now.difference(sixAM);
    } else {
      _remainingTime = Duration.zero;
      _elapsedTime = Duration.zero;
      _timer?.cancel(); // Stop timer if time exceeds 10 PM
    }
  }

  String? action;
  String _letter = '';
  int _level = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        action = null;
        _letter = '';
        _level = 0;
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setDialogState) {
                return AlertDialog(
                    content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text("Pause"),
                          selected: action == "Pause",
                          onSelected: (selected) {
                            setDialogState(() {});

                            action = "Pause";
                          },
                        ),
                        ChoiceChip(
                          label: const Text("Stop"),
                          selected: action == "Stop",
                          onSelected: (selected) {
                            setDialogState(() {});
                            action = "Stop";
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (String letter in ["m", "f", "s"])
                          ChoiceChip(
                            label: Text(letter),
                            selected: letter == _letter,
                            onSelected: (bool selected) {
                              setDialogState(() {
                                _letter = letter;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        const Text("Level"),
                        const SizedBox(
                          width: 10,
                        ),
                        for (int i in List.generate(5, (index) => index + 1))
                          ChoiceChip(
                            label: Text(i.toString()),
                            selected: i == _level,
                            onSelected: (bool selected) {
                              setDialogState(() {
                                _level = i;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        ref
                            .read(progressModelController.notifier)
                            .pause(_letter, action);
                        ref
                            .read(progressModelController.notifier)
                            .setLevel(_level);

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ],
                ));
              },
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTab1View(label: 'Remaining', time: _remainingTime),
            const SizedBox(
              height: 20,
            ),
            _buildTab1View(label: 'Elapsed', time: _elapsedTime),
          ],
        ),
      ),
    );
  }

  Widget _buildTab1View({required String label, required Duration time}) {
    final hours = time.inHours % 24;
    final minutes = time.inMinutes % 60;
    final seconds = time.inSeconds % 60;

    return Row(
      children: [
        Text(label),
        Expanded(
          child: Container(),
        ),
        Text(
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 18, letterSpacing: 6)),
      ],
    );
  }
}
