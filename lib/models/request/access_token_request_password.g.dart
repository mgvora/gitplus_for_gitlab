// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_request_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenReqestPassword _$AccessTokenReqestPasswordFromJson(
        Map<String, dynamic> json) =>
    AccessTokenReqestPassword(
      grantType: json['grant_type'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AccessTokenReqestPasswordToJson(
        AccessTokenReqestPassword instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'username': instance.username,
      'password': instance.password,
    };
