import 'package:json_annotation/json_annotation.dart';
part '../_generated/register/register_request.g.dart';

@JsonSerializable(includeIfNull: false)
class RegisterRequestModel {
    String? phone;
    String? name;
    String? surname;
    int? cityId;
    int? districtId;
    bool? kvkk;
    bool? sendAd;
    List<int>? roles;

  RegisterRequestModel({
        this.phone,
        this.name,
        this.surname,
        this.cityId,
        this.districtId,
        this.kvkk,
        this.sendAd,
        this.roles,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}