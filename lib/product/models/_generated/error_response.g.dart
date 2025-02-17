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

Map<String, dynamic> _$ErrorResponseModelToJson(ErrorResponseModel instance) =>
    <String, dynamic>{
      if (instance.code case final value?) 'code': value,
      if (instance.parameters case final value?) 'parameters': value,
      if (instance.validationErrors case final value?)
        'validationErrors': value,
    };
