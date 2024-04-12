import 'package:flutter/material.dart';
import 'dart:async';

class Tab1View extends StatefulWidget {
  @override
  _Tab1ViewState createState() => _Tab1ViewState();
}

class _Tab1ViewState extends State<Tab1View> {
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
    final tenPM = DateTime(now.year, now.month, now.day, 23, 55);
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
    final tenPM = DateTime(now.year, now.month, now.day, 23, 55);
    final sixAM = DateTime(now.year, now.month, now.day, 6, 0);

    if (now.isBefore(tenPM) && now.isAfter(sixAM)) {
      _remainingTime = tenPM.difference(now);
      _elapsedTime = now.difference(sixAM);
    } else {
      _remainingTime = Duration.zero;
      _elapsedTime = Duration.zero;
      _timer?.cancel(); // Stop timer if time exceeds 10 PM
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTab1View(label: 'Remaining', time: _remainingTime),
        _buildTab1View(label: 'Elapsed', time: _elapsedTime),
      ],
    );
  }

  Widget _buildTab1View({required String label, required Duration time}) {
    final hours = time.inHours % 24;
    final minutes = time.inMinutes % 60;
    final seconds = time.inSeconds % 60;

    return Column(
      children: [
        Text(label),
        Text(
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
