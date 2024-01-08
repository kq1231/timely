import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';
import 'package:timely/modules/tab_1/tokens/tab_1_constants.dart';

class Tab1HeaderRowMolecule extends StatelessWidget {
  const Tab1HeaderRowMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    return TextRowMolecule(
      texts: Tab1Constants.headers,
      bolded: true,
      customWidths: const {0: 70},
    );
  }
}
