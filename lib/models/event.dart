import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'event.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Event {
  final int? id;
  final int? projectId;
  final int? targetId;
  final int? targetIid;
  final String? actionName; // EventActionNames
  final String? targetType; // EventTargetTypes
  final String? targetTitle;
  final int? authorId;
  final DateTime? createdAt;
  final Note? note;
  final Author? author;
  final EventPushData? pushData;
  final String? authorUsername;

  Event({
    this.id,
    this.projectId,
    this.targetId,
    this.targetIid,
    this.actionName,
    this.targetType,
    this.targetTitle,
    this.authorId,
    this.createdAt,
    this.note,
    this.author,
    this.pushData,
    this.authorUsername,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
