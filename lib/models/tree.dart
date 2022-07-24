import 'package:json_annotation/json_annotation.dart';

part 'tree.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Tree {
  final String? id;
  final String? name;
  final String? type;
  final String? path;
  final String? mode;

  Tree({
    this.id,
    this.name,
    this.type,
    this.path,
    this.mode,
  });

  factory Tree.fromJson(Map<String, dynamic> json) => _$TreeFromJson(json);

  Map<String, dynamic> toJson() => _$TreeToJson(this);
}
