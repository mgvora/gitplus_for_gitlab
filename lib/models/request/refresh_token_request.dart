import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RefreshTokenRequest {
  final String grantType, refreshToken;

  RefreshTokenRequest({
    required this.grantType,
    required this.refreshToken,
  });

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
