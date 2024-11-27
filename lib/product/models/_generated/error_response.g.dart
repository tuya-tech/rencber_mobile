// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseModel<T> _$ErrorResponseModelFromJson<T>(
        Map<String, dynamic> json) =>
    ErrorResponseModel<T>(
      code: json['code'] as String?,
      parameters: (json['parameters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ErrorResponseModelToJson<T>(
    ErrorResponseModel<T> instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('parameters', instance.parameters);
  return val;
}
