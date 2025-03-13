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
      bitkiId: (json['bitkiId'] as num?)?.toInt(),
      buyumeTipi: json['buyumeTipi'] as String?,
      day: (json['day'] as num?)?.toInt(),
      ekimDate: json['ekimDate'] as String?,
      sulamadaGubreYapilacak: json['sulamadaGubreYapilacak'] as bool?,
      gubreTipleri: (json['gubreTipleri'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FieldResponseModelToJson(FieldResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.city case final value?) 'city': value,
      if (instance.district case final value?) 'district': value,
      if (instance.name case final value?) 'name': value,
      if (instance.active case final value?) 'active': value,
      if (instance.outline case final value?) 'outline': value,
      if (instance.bitkiName case final value?) 'bitkiName': value,
      if (instance.bitkiId case final value?) 'bitkiId': value,
      if (instance.buyumeTipi case final value?) 'buyumeTipi': value,
      if (instance.day case final value?) 'day': value,
      if (instance.ekimDate case final value?) 'ekimDate': value,
      if (instance.sulamadaGubreYapilacak case final value?)
        'sulamadaGubreYapilacak': value,
      if (instance.gubreTipleri case final value?) 'gubreTipleri': value,
    };
