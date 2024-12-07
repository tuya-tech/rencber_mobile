import 'package:json_annotation/json_annotation.dart';
part '../_generated/news/news_response.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsResponseModel {
  int? id;
  String? title;
  String? summary;
  String? date;
  String? content;
  bool? outline;
  bool? status;
  String? imagePath;
  String? image;

  NewsResponseModel({
    this.id,
    this.title,
    this.summary,
    this.date,
    this.content,
    this.outline,
    this.status,
    this.imagePath,
    this.image,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) => _$NewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseModelToJson(this);
}
