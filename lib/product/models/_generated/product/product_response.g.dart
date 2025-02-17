// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../product/product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseModel _$ProductResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductResponseModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      capalamaGerekli: json['capalamaGerekli'] as bool?,
      sulamaDonguSayisi: (json['sulamaDonguSayisi'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductResponseModelToJson(
        ProductResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.capalamaGerekli case final value?) 'capalamaGerekli': value,
      if (instance.sulamaDonguSayisi case final value?)
        'sulamaDonguSayisi': value,
    };
