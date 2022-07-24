import 'package:json_annotation/json_annotation.dart';

part 'project_namespace.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProjectNamespace {
  final int? id;
  final String? name;
  final String? path;
  final String? fullPath;
  final String? avatarUrl;
  final String? webUrl;

  ProjectNamespace({
    this.id,
    this.name,
    this.path,
    this.fullPath,
    this.avatarUrl,
    this.webUrl,
  });

  factory ProjectNamespace.fromJson(Map<String, dynamic> json) =>
      _$ProjectNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectNamespaceToJson(this);
}
