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

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('phone', instance.phone);
  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('email', instance.email);
  writeNotNull('gender', instance.gender);
  writeNotNull('phoneApproved', instance.phoneApproved);
  writeNotNull('detailAddress', instance.detailAddress);
  writeNotNull('kvkk', instance.kvkk);
  writeNotNull('sendAd', instance.sendAd);
  writeNotNull('city', instance.city);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('district', instance.district);
  return val;
}
