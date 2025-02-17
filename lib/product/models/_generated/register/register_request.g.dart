// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../register/register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegisterRequestModel(
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      cityId: (json['cityId'] as num?)?.toInt(),
      districtId: (json['districtId'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      kvkk: json['kvkk'] as bool?,
      sendAd: json['sendAd'] as bool?,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      if (instance.phone case final value?) 'phone': value,
      if (instance.name case final value?) 'name': value,
      if (instance.surname case final value?) 'surname': value,
      if (instance.cityId case final value?) 'cityId': value,
      if (instance.districtId case final value?) 'districtId': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.kvkk case final value?) 'kvkk': value,
      if (instance.sendAd case final value?) 'sendAd': value,
    };
