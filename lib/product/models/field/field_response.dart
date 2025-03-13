import 'package:json_annotation/json_annotation.dart';
import 'package:rencber_mobile/product/models/_global/city.dart';
part '../_generated/field/field_response.g.dart';

@JsonSerializable(includeIfNull: false)
class FieldResponseModel {
  int? id;
  CityModel? city;
  CityModel? district;
  String? name;
  bool? active;
  bool? outline;
  String? bitkiName;
  int? bitkiId;
  String? buyumeTipi;
  int? day;
  String? ekimDate;
  bool? sulamadaGubreYapilacak;
  List<String>? gubreTipleri;

  FieldResponseModel({
    this.id,
    this.city,
    this.district,
    this.name,
    this.active,
    this.outline,
    this.bitkiName,
    this.bitkiId,
    this.buyumeTipi,
    this.day,
    this.ekimDate,
    this.sulamadaGubreYapilacak,
    this.gubreTipleri,
  });

  factory FieldResponseModel.fromJson(Map<String, dynamic> json) => _$FieldResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FieldResponseModelToJson(this);
}
