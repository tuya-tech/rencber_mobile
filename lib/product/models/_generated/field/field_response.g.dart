// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../field/field_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldResponseModel _$FieldResponseModelFromJson(Map<String, dynamic> json) =>
    FieldResponseModel(
      id: (json['id'] as num?)?.toInt(),
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : CityModel.fromJson(json['district'] as Map<String, dynamic>),
      name: json['name'] as String?,
      active: json['active'] as bool?,
      outline: json['outline'] as bool?,
      bitkiName: json['bitkiName'] as String?,
      buyumeTipi: json['buyumeTipi'] as String?,
      day: (json['day'] as num?)?.toInt(),
      ekimDate: json['ekimDate'] as String?,
      sulamadaGubreYapilacak: json['sulamadaGubreYapilacak'] as bool?,
      gubreTipi: json['gubreTipi'] as String?,
    );

Map<String, dynamic> _$FieldResponseModelToJson(FieldResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('city', instance.city);
  writeNotNull('district', instance.district);
  writeNotNull('name', instance.name);
  writeNotNull('active', instance.active);
  writeNotNull('outline', instance.outline);
  writeNotNull('bitkiName', instance.bitkiName);
  writeNotNull('buyumeTipi', instance.buyumeTipi);
  writeNotNull('day', instance.day);
  writeNotNull('ekimDate', instance.ekimDate);
  writeNotNull('sulamadaGubreYapilacak', instance.sulamadaGubreYapilacak);
  writeNotNull('gubreTipi', instance.gubreTipi);
  return val;
}
