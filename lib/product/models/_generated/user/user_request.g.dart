// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../user/user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequestModel _$UserRequestModelFromJson(Map<String, dynamic> json) =>
    UserRequestModel(
      id: (json['id'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      cityId: (json['cityId'] as num?)?.toInt(),
      districtId: (json['districtId'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      sendAd: json['sendAd'] as bool?,
      birthday: json['birthday'] as String?,
      email: json['email'] as String?,
      detailAddress: json['detailAddress'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$UserRequestModelToJson(UserRequestModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.name case final value?) 'name': value,
      if (instance.surname case final value?) 'surname': value,
      if (instance.cityId case final value?) 'cityId': value,
      if (instance.districtId case final value?) 'districtId': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.sendAd case final value?) 'sendAd': value,
      if (instance.birthday case final value?) 'birthday': value,
      if (instance.email case final value?) 'email': value,
      if (instance.detailAddress case final value?) 'detailAddress': value,
      if (instance.roles case final value?) 'roles': value,
    };
