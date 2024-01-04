import 'package:uuid/uuid.dart';

class Tab12SubEntryModel {
  String? uuid;
  String nextTask = "";

  Tab12SubEntryModel({
    required this.nextTask,
  });

  Map toJson() => {
        "ID": uuid ?? const Uuid().v4(),
        "Next Task": nextTask,
      };

  Tab12SubEntryModel.fromJson(Map json) {
    uuid = json["ID"];
    nextTask = json["Next Task"];
  }

  Tab12SubEntryModel copyWith({String? uuid, String? nextTask}) {
    return Tab12SubEntryModel(
      nextTask: nextTask ?? this.nextTask,
    );
  }
}
