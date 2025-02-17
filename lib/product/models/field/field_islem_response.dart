import 'package:json_annotation/json_annotation.dart';
part '../_generated/field/field_islem_response.g.dart';

@JsonSerializable(includeIfNull: false)
class FieldIslemResponseModel {
  int? id;
  String? islemTipi;
  String? startDate;
  String? endDate;


  FieldIslemResponseModel({
    this.id,
    this.islemTipi,
    this.startDate,
    this.endDate,
  });

  factory FieldIslemResponseModel.fromJson(Map<String, dynamic> json) => _$FieldIslemResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FieldIslemResponseModelToJson(this);
}
