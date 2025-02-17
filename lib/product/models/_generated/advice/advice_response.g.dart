// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../advice/advice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdviceResponseModel _$AdviceResponseModelFromJson(Map<String, dynamic> json) =>
    AdviceResponseModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      imagePath: json['imagePath'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      brand: json['brand'] as String?,
      sponsored: json['sponsored'] as bool?,
      image: json['image'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      webSite: json['webSite'] as String?,
    );

Map<String, dynamic> _$AdviceResponseModelToJson(
        AdviceResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.title case final value?) 'title': value,
      if (instance.summary case final value?) 'summary': value,
      if (instance.content case final value?) 'content': value,
      if (instance.imagePath case final value?) 'imagePath': value,
      if (instance.price case final value?) 'price': value,
      if (instance.brand case final value?) 'brand': value,
      if (instance.sponsored case final value?) 'sponsored': value,
      if (instance.image case final value?) 'image': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.webSite case final value?) 'webSite': value,
    };
