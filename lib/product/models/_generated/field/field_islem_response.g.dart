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
    FieldIslemResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('islemTipi', instance.islemTipi);
  writeNotNull('startDate', instance.startDate);
  writeNotNull('endDate', instance.endDate);
  return val;
}
