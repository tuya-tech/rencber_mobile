import 'package:json_annotation/json_annotation.dart';
part '../_generated/_global/city.g.dart';

@JsonSerializable(includeIfNull: false)
class CityModel {
  final int? id;
  final bool? deleted;
  final dynamic createdBy;
  final String? createdDate;
  final dynamic lastUpdatedBy;
  final String? lastUpdatedDate;
  final String? name;
  final CityModel? city;

  CityModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.createdDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.name,
    this.city,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
