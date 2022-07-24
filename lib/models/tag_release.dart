import 'package:json_annotation/json_annotation.dart';

part 'tag_release.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TagRelase {
  final String? tagName;
  final String? description;

  TagRelase({
    this.tagName,
    this.description,
  });

  factory TagRelase.fromJson(Map<String, dynamic> json) =>
      _$TagRelaseFromJson(json);

  Map<String, dynamic> toJson() => _$TagRelaseToJson(this);
}
