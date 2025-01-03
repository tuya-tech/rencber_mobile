// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseModel _$ErrorResponseModelFromJson(Map<String, dynamic> json) =>
    ErrorResponseModel(
      code: json['code'] as String?,
      parameters: (json['parameters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      validationErrors: json['validationErrors'] as String?,
    );

Map<String, dynamic> _$ErrorResponseModelToJson(ErrorResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('parameters', instance.parameters);
  writeNotNull('validationErrors', instance.validationErrors);
  return val;
}
