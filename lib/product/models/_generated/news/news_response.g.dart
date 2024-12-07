// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../news/news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponseModel _$NewsResponseModelFromJson(Map<String, dynamic> json) =>
    NewsResponseModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      date: json['date'] as String?,
      content: json['content'] as String?,
      outline: json['outline'] as bool?,
      status: json['status'] as bool?,
      imagePath: json['imagePath'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$NewsResponseModelToJson(NewsResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('summary', instance.summary);
  writeNotNull('date', instance.date);
  writeNotNull('content', instance.content);
  writeNotNull('outline', instance.outline);
  writeNotNull('status', instance.status);
  writeNotNull('imagePath', instance.imagePath);
  writeNotNull('image', instance.image);
  return val;
}
