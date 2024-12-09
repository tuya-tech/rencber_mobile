import 'package:json_annotation/json_annotation.dart';
import 'package:rencber_mobile/product/models/_global/city.dart';
part '../_generated/user/user_response.g.dart';

@JsonSerializable(includeIfNull: false)
class UserResponseModel {
  final int? id;
  final String? phone;
  final String? name;
  final String? surname;
  final String? email;
  final String? gender;
  final bool? phoneApproved;
  final String? detailAddress;
  final bool? kvkk;
  final bool? sendAd;
  final CityModel? city;
  final String? birthday;
  final CityModel? district;

  UserResponseModel({
    this.id,
    this.phone,
    this.name,
    this.surname,
    this.email,
    this.gender,
    this.phoneApproved,
    this.detailAddress,
    this.kvkk,
    this.sendAd,
    this.city,
    this.birthday,
    this.district,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}
