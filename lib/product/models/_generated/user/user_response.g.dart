// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) =>
    UserResponseModel(
      id: (json['id'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phoneApproved: json['phoneApproved'] as bool?,
      detailAddress: json['detailAddress'] as String?,
      kvkk: json['kvkk'] as bool?,
      sendAd: json['sendAd'] as bool?,
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      birthday: json['birthday'] as String?,
      district: json['district'] == null
          ? null
          : CityModel.fromJson(json['district'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.name case final value?) 'name': value,
      if (instance.surname case final value?) 'surname': value,
      if (instance.email case final value?) 'email': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.phoneApproved case final value?) 'phoneApproved': value,
      if (instance.detailAddress case final value?) 'detailAddress': value,
      if (instance.kvkk case final value?) 'kvkk': value,
      if (instance.sendAd case final value?) 'sendAd': value,
      if (instance.city case final value?) 'city': value,
      if (instance.birthday case final value?) 'birthday': value,
      if (instance.district case final value?) 'district': value,
    };
