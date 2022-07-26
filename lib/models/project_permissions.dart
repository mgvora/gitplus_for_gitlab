import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_permissions.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProjectPermissions {
  final PermissionAccess? projectAccess;
  final PermissionAccess? groupAccess;

  ProjectPermissions({
    this.projectAccess,
    this.groupAccess,
  });

  factory ProjectPermissions.fromJson(Map<String, dynamic> json) =>
      _$ProjectPermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectPermissionsToJson(this);
}
