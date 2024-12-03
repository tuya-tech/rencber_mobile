import 'package:json_annotation/json_annotation.dart';
part '../_generated/news/news_response.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsResponseModel {
  String? title;
  String? summary;
  String? date;
  String? content;
  bool? outline;
  String? image;

  NewsResponseModel({
    this.title,
    this.summary,
    this.date,
    this.content,
    this.outline,
    this.image,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) => _$NewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseModelToJson(this);
}
