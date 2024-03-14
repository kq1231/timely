import 'package:flutter/material.dart';

class ScoreRow extends StatefulWidget {
  final String title;
  final String time;
  final int status;
  final double height;
  final List<double> sizes;
  final VoidCallback onTap;

  const ScoreRow({
    super.key,
    required this.title,
    required this.time,
    required this.sizes,
    required this.height,
    required this.onTap,
    required this.status,
  });

  @override
  State<ScoreRow> createState() => _ScoreRowState();
}

class _ScoreRowState extends State<ScoreRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(widget.title,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            Expanded(child: Container()),
            Text(widget.time, style: Theme.of(context).textTheme.bodyMedium),
            widget.status == 0
                ? SizedBox(
                    width: 45,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        // Calculate the current milliseconds value based on the animation
                        double milliseconds = _controller.value * 1000;
                        return Text(
                          ":${milliseconds.toStringAsFixed(0)}", // Display as integer
                          style: Theme.of(context).textTheme.bodyMedium,
                        );
                      },
                    ),
                  )
                : Container(),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  // ... (your build method)
}
