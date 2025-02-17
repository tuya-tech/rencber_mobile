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

Map<String, dynamic> _$FieldRequestModelToJson(FieldRequestModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.active case final value?) 'active': value,
      if (instance.outline case final value?) 'outline': value,
      if (instance.cityId case final value?) 'cityId': value,
      if (instance.districtId case final value?) 'districtId': value,
      if (instance.bitkiId case final value?) 'bitkiId': value,
      if (instance.ekimZamani case final value?) 'ekimZamani': value,
      if (instance.sulamadaGubreYapilacak case final value?)
        'sulamadaGubreYapilacak': value,
      if (instance.gubreTipi case final value?) 'gubreTipi': value,
    };
