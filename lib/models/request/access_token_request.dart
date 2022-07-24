import 'package:json_annotation/json_annotation.dart';

part 'access_token_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AccessTokenReqest {
  final String clientId,
      clientSecret,
      code,
      grantType,
      redirectUri,
      codeVerifier;

  AccessTokenReqest({
    required this.clientId,
    required this.clientSecret,
    required this.code,
    required this.grantType,
    required this.redirectUri,
    required this.codeVerifier,
  });

  factory AccessTokenReqest.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenReqestFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenReqestToJson(this);
}
