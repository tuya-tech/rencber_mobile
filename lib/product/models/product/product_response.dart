import 'package:json_annotation/json_annotation.dart';
part '../_generated/product/product_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ProductResponseModel {
  int? id;
  String? name;
  bool? capalamaGerekli;
  int? sulamaDonguSayisi;

  ProductResponseModel({
    this.id,
    this.name,
    this.capalamaGerekli,
    this.sulamaDonguSayisi,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) => _$ProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);
}
