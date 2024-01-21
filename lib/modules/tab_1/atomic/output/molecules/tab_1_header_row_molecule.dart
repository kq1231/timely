import 'package:flutter/material.dart';
import 'package:timely/common/atomic/molecules/molecules.dart';

import '../../../tokens/tab_1.dart';

class Tab1HeaderRowMolecule extends StatelessWidget {
  const Tab1HeaderRowMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    return TextRowMolecule(
      texts: Tab1Constants.headers,
      minHeight: 40,
      bolded: true,
      customWidths: const {0: 70},
    );
  }
}
