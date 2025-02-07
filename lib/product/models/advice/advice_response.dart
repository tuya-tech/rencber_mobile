import 'package:json_annotation/json_annotation.dart';
part '../_generated/advice/advice_response.g.dart';

@JsonSerializable(includeIfNull: false)
class AdviceResponseModel {
  int? id;
  String? title;
  String? summary;
  String? content;
  String? imagePath;
  double? price;
  String? brand;
  bool? sponsored;
  String? image;
  double? latitude;
  double? longitude;
  String? webSite;

  AdviceResponseModel({
    this.id,
    this.title,
    this.summary,
    this.content,
    this.imagePath,
    this.price,
    this.brand,
    this.sponsored,
    this.image,
    this.latitude,
    this.longitude,
    this.webSite,
  });

  factory AdviceResponseModel.fromJson(Map<String, dynamic> json) => _$AdviceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdviceResponseModelToJson(this);
}
