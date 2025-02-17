// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../field/field_islem_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldIslemResponseModel _$FieldIslemResponseModelFromJson(
        Map<String, dynamic> json) =>
    FieldIslemResponseModel(
      id: (json['id'] as num?)?.toInt(),
      islemTipi: json['islemTipi'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$FieldIslemResponseModelToJson(
        FieldIslemResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.islemTipi case final value?) 'islemTipi': value,
      if (instance.startDate case final value?) 'startDate': value,
      if (instance.endDate case final value?) 'endDate': value,
    };
