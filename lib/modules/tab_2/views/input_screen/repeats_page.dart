import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/tab_2/controllers/input_controller.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/modules/tab_2/views/input_screen/selectors/monthly.dart';
import 'package:timely/modules/tab_2/views/input_screen/selectors/yearly.dart';

class RepeatsPage extends ConsumerWidget {
  const RepeatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab2InputProvider);
    final controller = ref.read(tab2InputProvider.notifier);
    return ListView(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Center(
              child: DropdownButton(
                items: Tab2InputLayout.repeatDropdownButtonItems,
                onChanged: (value) {
                  controller.setFrequency(value);
                  if (value == "Yearly") {
                    controller.setRepetitions([
                      [],
                      [0, 0]
                    ]);
                  }
                },
                value: provider.frequency,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Center(
              child: Text(
                Tab2InputLayout.repeatText,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        // End repeat button
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Center(
              child: OutlinedButton(
                onPressed: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(0),
                      lastDate: DateTime(DateTime.now().year + 50));

                  if (selectedDate != null) {
                    controller.setEndDate(selectedDate);
                  }
                },
                child: Text(provider.endDate != null
                    ? DateFormat(DateFormat.ABBR_MONTH_DAY)
                        .format(provider.endDate!)
                    : "Never"),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Center(
              child: Text(
                Tab2InputLayout.endRepeatText,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        provider.frequency == Frequency.monthly
            ? const MonthlySelector()
            : const YearlySelector(),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: IconButton.filledTonal(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.done),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
