// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_completion_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskCompletionStatus _$TaskCompletionStatusFromJson(
        Map<String, dynamic> json) =>
    TaskCompletionStatus(
      count: json['count'] as int?,
      completedCount: json['completed_count'] as int?,
    );

Map<String, dynamic> _$TaskCompletionStatusToJson(
        TaskCompletionStatus instance) =>
    <String, dynamic>{
      'count': instance.count,
      'completed_count': instance.completedCount,
    };
