import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/app_theme.dart';
import 'package:timely/modules/tab_2_6_7/controllers/input_controller.dart';
import 'package:timely/modules/tab_2_6_7/models/tab_2_model.dart';
import 'package:timely/modules/tab_2_6_7/views/input_screen/selectors/monthly.dart';
import 'package:timely/modules/tab_2_6_7/views/input_screen/selectors/weekly.dart';
import 'package:timely/modules/tab_2_6_7/views/input_screen/selectors/yearly.dart';

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
                  controller.setBasis(Basis.day); // Set default basis to "Day".

                  // Set the default values based on selection
                  switch (value) {
                    case "Monthly":
                      controller.setRepetitions({
                        "DoW": [0, 0]
                      });
                      break;
                    case "Yearly":
                      controller.setRepetitions({
                        "Months": [],
                        "DoW": [0, 0]
                      });
                    case "Weekly":
                      controller.resetBasis();
                      controller.setRepetitions({"Weekdays": []});
                    case "Daily":
                      controller.setRepetitions({});
                  }
                  controller.setFrequency(value);
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
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 30,
              child: TextFormField(
                initialValue: provider.every.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  try {
                    controller.setEvery(int.parse(value));
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
              ),
            ),
            Expanded(
              child: Container(),
            ),
            const Text("Every"),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        const SizedBox(
          height: 20,
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
                      firstDate: DateTime.now(),
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
        [
          Container(),
          const MonthlySelector(),
          const WeeklySelector(),
          const YearlySelector(),
          Container()
        ][[
          "Daily",
          "Monthly",
          "Weekly",
          "Yearly",
          "Never",
        ].indexOf(provider.frequency ?? "Never")],
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
