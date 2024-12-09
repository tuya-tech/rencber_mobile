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

Map<String, dynamic> _$UserRequestModelToJson(UserRequestModel instance) {
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
  writeNotNull('cityId', instance.cityId);
  writeNotNull('districtId', instance.districtId);
  writeNotNull('gender', instance.gender);
  writeNotNull('sendAd', instance.sendAd);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('email', instance.email);
  writeNotNull('detailAddress', instance.detailAddress);
  writeNotNull('roles', instance.roles);
  return val;
}
