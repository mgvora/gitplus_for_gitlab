import 'package:json_annotation/json_annotation.dart';

part 'event_push_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EventPushData {
  final int? commitCount;
  final String? action;
  final String? refType;
  final String? commitFrom;
  final String? commitTo;
  final String? ref;
  final String? commitTitle;
  final int? refCount;

  EventPushData({
    this.commitCount,
    this.action,
    this.refType,
    this.commitFrom,
    this.commitTo,
    this.ref,
    this.commitTitle,
    this.refCount,
  });

  factory EventPushData.fromJson(Map<String, dynamic> json) =>
      _$EventPushDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventPushDataToJson(this);
}
