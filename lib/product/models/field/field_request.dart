import 'package:json_annotation/json_annotation.dart';
part '../_generated/field/field_request.g.dart';

@JsonSerializable(includeIfNull: false)
class FieldRequestModel {
  int? id;
  String? name;
  bool? active;
  bool? outline;
  int? cityId;
  int? districtId;
  int? bitkiId;
  String? ekimZamani;
  bool? sulamadaGubreYapilacak;
  String? gubreTipi;

  FieldRequestModel({
    this.id,
    this.name,
    this.active,
    this.outline,
    this.cityId,
    this.districtId,
    this.bitkiId,
    this.ekimZamani,
    this.sulamadaGubreYapilacak,
    this.gubreTipi,
  });

  factory FieldRequestModel.fromJson(Map<String, dynamic> json) => _$FieldRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$FieldRequestModelToJson(this);
}
