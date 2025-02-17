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

Map<String, dynamic> _$NewsResponseModelToJson(NewsResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.title case final value?) 'title': value,
      if (instance.summary case final value?) 'summary': value,
      if (instance.date case final value?) 'date': value,
      if (instance.content case final value?) 'content': value,
      if (instance.outline case final value?) 'outline': value,
      if (instance.status case final value?) 'status': value,
      if (instance.imagePath case final value?) 'imagePath': value,
      if (instance.image case final value?) 'image': value,
    };
