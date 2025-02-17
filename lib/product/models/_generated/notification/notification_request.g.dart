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
        NotificationRequestModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.allowNotifications case final value?)
        'allowNotifications': value,
      if (instance.allowSms case final value?) 'allowSms': value,
      if (instance.allowEmail case final value?) 'allowEmail': value,
    };
