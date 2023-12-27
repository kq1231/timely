import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_9/controllers/input/sub_entry_input_controller.dart';

class Tab9SubEntryInputMolecule extends ConsumerWidget {
  const Tab9SubEntryInputMolecule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(tab9SubEntryInputProvider);
    final controller = ref.read(tab9SubEntryInputProvider.notifier);

    List<int> hourAndMinute =
        provider.time.split(":").map((e) => int.parse(e)).toList();
    TimeOfDay time =
        TimeOfDay(hour: hourAndMinute[0], minute: hourAndMinute[1]);

    return Column(
      children: [
        SizedBox(
          width: 170,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              var dateSelected = await showDatePicker(
                  context: context,
                  initialDate: provider.date,
                  firstDate: DateTime(0),
                  lastDate: DateTime(
                    DateTime.now().year + 50,
                  ));
              if (dateSelected != null) {
                controller.setDate(dateSelected);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              controller.getFormattedDate(),
            ),
          ),
        ),
        const Divider(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Time"),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    var timeSelected = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    if (timeSelected != null) {
                      controller.setTime(
                          [timeSelected.hour, timeSelected.minute].join(":"));
                    }
                  },
                  child: Text(time.format(context)),
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.task,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Task",
            ),
            onChanged: (task) {
              controller.setTask(task);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            initialValue: provider.description,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              filled: true,
              hintText: "Description & Update",
            ),
            onChanged: (description) {
              controller.setDescription(description);
            },
          ),
        ),
        const Divider(
          height: 40,
        ),
      ],
    );
  }
}
