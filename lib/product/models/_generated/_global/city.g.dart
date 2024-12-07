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

Map<String, dynamic> _$CityModelToJson(CityModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('deleted', instance.deleted);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('createdDate', instance.createdDate);
  writeNotNull('lastUpdatedBy', instance.lastUpdatedBy);
  writeNotNull('lastUpdatedDate', instance.lastUpdatedDate);
  writeNotNull('name', instance.name);
  writeNotNull('city', instance.city);
  return val;
}
