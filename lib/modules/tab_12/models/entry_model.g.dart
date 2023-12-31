// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Tab12EntryModelImpl _$$Tab12EntryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$Tab12EntryModelImpl(
      uuid: json['ID'] as String?,
      activity: json['activity'] as String,
      objective: json['objective'] as String,
      importance: json['importance'] as int,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$Tab12EntryModelImplToJson(
        _$Tab12EntryModelImpl instance) =>
    <String, dynamic>{
      'ID': instance.uuid ?? const Uuid().v4(),
      'activity': instance.activity,
      'objective': instance.objective,
      'importance': instance.importance,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
