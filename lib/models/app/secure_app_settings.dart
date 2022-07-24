import 'package:gitplus_for_gitlab/models/app/app_account.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'secure_app_settings.g.dart';

@JsonSerializable()
class SecureAppSettings {
  List<AppAccount>? accounts;
  int? defaultId;

  SecureAppSettings({
    this.accounts,
    this.defaultId = -1,
  });

  String toJsonString() => json.encode(toJson());

  factory SecureAppSettings.fromJson(Map<String, dynamic> json) =>
      _$SecureAppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SecureAppSettingsToJson(this);
}
