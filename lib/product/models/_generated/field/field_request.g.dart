// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../field/field_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldRequestModel _$FieldRequestModelFromJson(Map<String, dynamic> json) =>
    FieldRequestModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      active: json['active'] as bool?,
      outline: json['outline'] as bool?,
      cityId: (json['cityId'] as num?)?.toInt(),
      districtId: (json['districtId'] as num?)?.toInt(),
      bitkiId: (json['bitkiId'] as num?)?.toInt(),
      ekimZamani: json['ekimZamani'] as String?,
      sulamadaGubreYapilacak: json['sulamadaGubreYapilacak'] as bool?,
      gubreTipi: json['gubreTipi'] as String?,
    );

Map<String, dynamic> _$FieldRequestModelToJson(FieldRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('active', instance.active);
  writeNotNull('outline', instance.outline);
  writeNotNull('cityId', instance.cityId);
  writeNotNull('districtId', instance.districtId);
  writeNotNull('bitkiId', instance.bitkiId);
  writeNotNull('ekimZamani', instance.ekimZamani);
  writeNotNull('sulamadaGubreYapilacak', instance.sulamadaGubreYapilacak);
  writeNotNull('gubreTipi', instance.gubreTipi);
  return val;
}
