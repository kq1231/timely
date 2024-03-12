import 'package:flutter/material.dart';

class ScoreRowMolecule extends StatelessWidget {
  final String title;
  final String time;
  final double height;
  final List<double> sizes;
  final VoidCallback onTap;

  const ScoreRowMolecule({
    super.key,
    required this.title,
    required this.time,
    required this.sizes,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: sizes[0],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:
                    Text(title, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            Expanded(child: Container()),
            Text(time, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
