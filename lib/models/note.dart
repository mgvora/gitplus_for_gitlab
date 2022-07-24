import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Note {
  final int? id;
  final String? body;
  final String? attachement;
  final Author? author;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? system;
  final int? noteableId;
  final String? noteableType; // NotableType
  final int? noteableIid;
  final bool? resolvable;
  final bool? confidential;

  Note({
    this.id,
    this.body,
    this.attachement,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.system,
    this.noteableId,
    this.noteableType,
    this.noteableIid,
    this.resolvable,
    this.confidential,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
