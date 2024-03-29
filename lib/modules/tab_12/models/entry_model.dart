import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timely/common/scheduling/scheduling_model.dart';

// required: associates our `entry_model.dart` with the code generated by Freezed
part 'entry_model.freezed.dart';
// optional: Since our Tab12EntryModel class is serializable, we must add this line.
// But if Tab12EntryModel was not serializable, we could skip it.
part 'entry_model.g.dart';

@freezed
class Tab12EntryModel with _$Tab12EntryModel {
  factory Tab12EntryModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: "ID") String? uuid,
    required String activity,
    required String objective,
    required SchedulingModel tab2Model,
    required int importance,
  }) = _Tab12EntryModel;

  factory Tab12EntryModel.fromJson(Map<String, Object?> json) =>
      _$Tab12EntryModelFromJson(json);
}
