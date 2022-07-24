// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecureAppSettings _$SecureAppSettingsFromJson(Map<String, dynamic> json) =>
    SecureAppSettings(
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => AppAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultId: json['defaultId'] as int? ?? -1,
    );

Map<String, dynamic> _$SecureAppSettingsToJson(SecureAppSettings instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
      'defaultId': instance.defaultId,
    };
