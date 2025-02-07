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

Map<String, dynamic> _$AdviceResponseModelToJson(AdviceResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('summary', instance.summary);
  writeNotNull('content', instance.content);
  writeNotNull('imagePath', instance.imagePath);
  writeNotNull('price', instance.price);
  writeNotNull('brand', instance.brand);
  writeNotNull('sponsored', instance.sponsored);
  writeNotNull('image', instance.image);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('webSite', instance.webSite);
  return val;
}
