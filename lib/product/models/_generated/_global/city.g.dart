// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../_global/city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'],
      createdDate: json['createdDate'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDate: json['lastUpdatedDate'] as String?,
      name: json['name'] as String?,
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.createdDate case final value?) 'createdDate': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.lastUpdatedDate case final value?) 'lastUpdatedDate': value,
      if (instance.name case final value?) 'name': value,
      if (instance.city case final value?) 'city': value,
    };
