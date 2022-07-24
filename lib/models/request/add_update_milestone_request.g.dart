// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_update_milestone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUpdateMilestoneRequest _$AddUpdateMilestoneRequestFromJson(
        Map<String, dynamic> json) =>
    AddUpdateMilestoneRequest(
      title: json['title'] as String?,
      description: json['description'] as String?,
      dueDate: json['due_date'] as String?,
      startDate: json['start_date'] as String?,
      stateEvent: json['state_event'] as String?,
    );

Map<String, dynamic> _$AddUpdateMilestoneRequestToJson(
    AddUpdateMilestoneRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('due_date', instance.dueDate);
  writeNotNull('start_date', instance.startDate);
  writeNotNull('state_event', instance.stateEvent);
  return val;
}
