import 'package:flutter/material.dart';

import 'package:timely/app_theme.dart';
import '../../atoms/buttons/text_button_atom.dart';

class CancelSubmitRowMolecule extends StatelessWidget {
  final VoidCallback onSubmitPressed;
  final VoidCallback onCancelPressed;

  const CancelSubmitRowMolecule({
    super.key,
    required this.onSubmitPressed,
    required this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButtonAtom(
              onPressed: onCancelPressed,
              text: "Cancel",
              color: AppColors.bgRed800,
            ),
            TextButtonAtom(
              color: AppColors.bgIndigo800,
              onPressed: onSubmitPressed,
              text: "Submit",
            ),
          ],
        ),
      ],
    );
  }
}
