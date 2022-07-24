import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Group {
  final int? id;
  final String? webUrl;
  final String? name;
  final String? path;
  final String? description;
  final String? visibility; // GitLabVisibility
  final bool? shareWithGroupLock;
  final bool? requireTwoFactorAuthentication;
  final int? twoFactorGracePeriod;
  final String? projectCreationLevel;
  final bool? autoDevopsEnabled;
  final String? subgroupCreationLevel;
  final bool? emailsDisabled;
  final bool? mentionsDisabled;
  final bool? lfsEnabled;
  final int? defaultBranchProtection;
  final String? avatarUrl;
  final bool? requestAccessEnabled;
  final String? fullName;
  final String? fullPath;
  final DateTime? createdAt;
  final int? parentId;

  Group({
    this.id,
    this.webUrl,
    this.name,
    this.path,
    this.description,
    this.visibility,
    this.shareWithGroupLock,
    this.requireTwoFactorAuthentication,
    this.twoFactorGracePeriod,
    this.projectCreationLevel,
    this.autoDevopsEnabled,
    this.subgroupCreationLevel,
    this.emailsDisabled,
    this.mentionsDisabled,
    this.lfsEnabled,
    this.defaultBranchProtection,
    this.avatarUrl,
    this.requestAccessEnabled,
    this.fullName,
    this.fullPath,
    this.createdAt,
    this.parentId,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
