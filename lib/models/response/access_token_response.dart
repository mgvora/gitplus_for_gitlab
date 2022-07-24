import 'package:json_annotation/json_annotation.dart';

part 'access_token_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AccessTokenResponse {
  final String? accessToken, tokenType, refreshToken, scope, idToken;
  final int? createdAt;

  AccessTokenResponse({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.scope,
    required this.createdAt,
    required this.idToken,
  });

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenResponseToJson(this);
}
