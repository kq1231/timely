import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
part 'sub_entry_model.freezed.dart';
part 'sub_entry_model.g.dart';

@Freezed()
class Tab9SubEntryModel with _$Tab9SubEntryModel {
  const factory Tab9SubEntryModel({
    String? uuid,
    required DateTime date,
    required String time,
    required String task,
    required String description,
  }) = _Tab9SubEntryModel;

  factory Tab9SubEntryModel.fromJson(Map<String, dynamic> json) =>
      _$Tab9SubEntryModelFromJson(json);
}
