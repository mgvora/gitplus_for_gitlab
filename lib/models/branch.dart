import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Branch {
  final String? name;
  final bool? merged;
  final bool? protected;
  final String? webUrl;

  Branch({
    this.name,
    this.merged,
    this.protected,
    this.webUrl,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
