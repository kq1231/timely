import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/common/atomic/atoms/text/text_form_field_atom.dart';
import 'package:timely/modules/tab_12/controllers/input/sub_entry_input_controller.dart';
import 'package:timely/tokens/app/app_sizes.dart';

class Tab12SubEntryInputMolecule extends ConsumerWidget {
  final bool? showNextOccurenceDate;
  const Tab12SubEntryInputMolecule({super.key, this.showNextOccurenceDate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab12SubEntryInputProvider);
    final controller = ref.read(tab12SubEntryInputProvider.notifier);

    return Column(
      children: [
        // Next Task TextField
        Padding(
          padding: const EdgeInsets.all(AppSizes.p_8),
          child: TextFormFieldAtom(
            initialValue: provider.nextTask,
            onChanged: (text) => controller.setName(text),
            hintText: "Next Task",
            isTextArea: true,
          ),
        ),
        const Divider(
          height: 40,
        ),
        showNextOccurenceDate == true
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Date"),
                        Text(DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                            .format(provider.date))
                      ],
                    ),
                  ),
                  const Divider(
                    height: 40,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
