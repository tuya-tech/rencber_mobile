import 'package:json_annotation/json_annotation.dart';
part '../_generated/register/register_request.g.dart';

@JsonSerializable(includeIfNull: false)
class RegisterRequestModel {
  final String? phone;
  final String? name;
  final String? surname;
  final int? cityId;
  final int? districtId;
  final String? gender;
  final bool? kvkk;
  final bool? sendAd;

  RegisterRequestModel({
    this.phone,
    this.name,
    this.surname,
    this.cityId,
    this.districtId,
    this.gender,
    this.kvkk,
    this.sendAd,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
