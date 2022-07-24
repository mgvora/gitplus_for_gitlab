import 'package:json_annotation/json_annotation.dart';

part 'access_token_request_password.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AccessTokenReqestPassword {
  final String grantType, username, password;

  AccessTokenReqestPassword({
    required this.grantType,
    required this.username,
    required this.password,
  });

  factory AccessTokenReqestPassword.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenReqestPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenReqestPasswordToJson(this);
}
