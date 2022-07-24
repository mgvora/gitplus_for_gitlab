// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenReqest _$AccessTokenReqestFromJson(Map<String, dynamic> json) =>
    AccessTokenReqest(
      clientId: json['client_id'] as String,
      clientSecret: json['client_secret'] as String,
      code: json['code'] as String,
      grantType: json['grant_type'] as String,
      redirectUri: json['redirect_uri'] as String,
      codeVerifier: json['code_verifier'] as String,
    );

Map<String, dynamic> _$AccessTokenReqestToJson(AccessTokenReqest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'client_secret': instance.clientSecret,
      'code': instance.code,
      'grant_type': instance.grantType,
      'redirect_uri': instance.redirectUri,
      'code_verifier': instance.codeVerifier,
    };
