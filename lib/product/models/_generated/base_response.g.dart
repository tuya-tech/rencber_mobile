// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel<T> _$BaseResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponseModel<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      message: json['message'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      errorCode: json['errorCode'] as String?,
    );

Map<String, dynamic> _$BaseResponseModelToJson<T>(
  BaseResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', _$nullableGenericToJson(instance.data, toJsonT));
  writeNotNull('message', instance.message);
  writeNotNull('statusCode', instance.statusCode);
  writeNotNull('errorCode', instance.errorCode);
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
