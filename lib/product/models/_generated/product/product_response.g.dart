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
    ProductResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('capalamaGerekli', instance.capalamaGerekli);
  writeNotNull('sulamaDonguSayisi', instance.sulamaDonguSayisi);
  return val;
}
