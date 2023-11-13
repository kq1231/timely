import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/controllers/input_controller.dart';

class Tab3InputScreen extends ConsumerWidget {
  const Tab3InputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(tab3InputProvider);
    final controller = ref.watch(tab3InputProvider.notifier);

    List labels = ["High", "Medium", "Low"];
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // Row of Radio buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(3, (index) {
                    return Column(
                      children: [
                        Radio(
                            value: model.priority,
                            groupValue: index,
                            onChanged: (val) {
                              controller.setPriority(index);
                              print(model.priority);
                            }),
                        const SizedBox(height: 10),
                        Text(labels[index]),
                      ],
                    );
                  })
                ],
              ),

              // Space
              const SizedBox(
                height: 30,
              ),

              // Row for selecting date and time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var dateSelected = await showDatePicker(
                          context: context,
                          initialDate: model.date == null
                              ? DateTime.now()
                              : DateTime.parse(model.date!),
                          firstDate: DateTime(2017, 1, 1),
                          lastDate: DateTime(DateTime.now().year + 2, 1, 1));
                      if (dateSelected != null) {
                        controller
                            .setDate(dateSelected.toString().substring(0, 10));
                      }
                    },
                    child: const Text("Select Date"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var timeSelected = await showTimePicker(
                          context: context,
                          initialTime: model.time ?? TimeOfDay.now());
                      if (timeSelected != null) {
                        controller.setTime(timeSelected);
                      }
                    },
                    child: const Text("Time"),
                  )
                ],
              ),

              // Space
              const SizedBox(
                height: 30,
              ),

              // Activity Comment/text_1
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    onChanged: (value) => controller.setActivity(value),
                  ),
                ),
              ),

              // Space
              const SizedBox(
                height: 30,
              ),

              // Submit Button and Cancel Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      controller.syncToDB();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Submitted Successfully'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
