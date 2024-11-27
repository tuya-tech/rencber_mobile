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
      kvkk: json['kvkk'] as bool?,
      sendAd: json['sendAd'] as bool?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
    RegisterRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('phone', instance.phone);
  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('cityId', instance.cityId);
  writeNotNull('districtId', instance.districtId);
  writeNotNull('kvkk', instance.kvkk);
  writeNotNull('sendAd', instance.sendAd);
  writeNotNull('roles', instance.roles);
  return val;
}
