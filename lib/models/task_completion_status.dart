import 'package:json_annotation/json_annotation.dart';

part 'task_completion_status.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskCompletionStatus {
  final int? count;
  final int? completedCount;

  TaskCompletionStatus({
    this.count,
    this.completedCount,
  });

  factory TaskCompletionStatus.fromJson(Map<String, dynamic> json) =>
      _$TaskCompletionStatusFromJson(json);

  Map<String, dynamic> toJson() => _$TaskCompletionStatusToJson(this);
}
