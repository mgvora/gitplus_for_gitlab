import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Tag {
  final TagCommit? commit;
  final TagRelase? release;
  final String? name;
  final String? target;
  final String? message;
  final bool? protected;

  Tag({
    this.commit,
    this.release,
    this.name,
    this.target,
    this.message,
    this.protected,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
