import 'package:gitplus_for_gitlab/models/project_namespace.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  final int? id;
  final String? description;
  final String? name;
  final String? nameWithNamespace;
  final String? path;
  final String? pathWithNamespace;
  final String? defaultBranch;
  final String? webUrl;
  final String? readmeUrl;
  final String? avatarUrl;
  final int? forksCount;
  final int? starCount;
  final String? visibility; // GitLabVisibility
  final DateTime? createdAt;
  final DateTime? lastActivityAt;
  final ProjectNamespace? namespace;
  final ProjectPermissions? permissions;

  Project({
    this.id,
    this.description,
    this.name,
    this.nameWithNamespace,
    this.path,
    this.pathWithNamespace,
    this.defaultBranch,
    this.webUrl,
    this.readmeUrl,
    this.avatarUrl,
    this.forksCount,
    this.starCount,
    this.visibility,
    this.createdAt,
    this.lastActivityAt,
    this.namespace,
    this.permissions,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
