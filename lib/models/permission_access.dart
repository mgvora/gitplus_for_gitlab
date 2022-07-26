import 'package:json_annotation/json_annotation.dart';

part 'permission_access.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PermissionAccess {
  final int? accessLevel;
  final int? notificationLevel;

  PermissionAccess({
    this.accessLevel,
    this.notificationLevel,
  });

  factory PermissionAccess.fromJson(Map<String, dynamic> json) =>
      _$PermissionAccessFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionAccessToJson(this);
}
