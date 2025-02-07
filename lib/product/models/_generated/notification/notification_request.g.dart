// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../notification/notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRequestModel _$NotificationRequestModelFromJson(
        Map<String, dynamic> json) =>
    NotificationRequestModel(
      id: (json['id'] as num?)?.toInt(),
      allowNotifications: json['allowNotifications'] as bool?,
      allowSms: json['allowSms'] as bool?,
      allowEmail: json['allowEmail'] as bool?,
    );

Map<String, dynamic> _$NotificationRequestModelToJson(
    NotificationRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('allowNotifications', instance.allowNotifications);
  writeNotNull('allowSms', instance.allowSms);
  writeNotNull('allowEmail', instance.allowEmail);
  return val;
}
