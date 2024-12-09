import 'package:json_annotation/json_annotation.dart';
part '../_generated/user/user_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UserRequestModel {
  final int? id;
  final String? phone;
  final String? name;
  final String? surname;
  final int? cityId;
  final int? districtId;
  final String? gender;
  final bool? sendAd;
  final String? birthday;
  final String? email;
  final String? detailAddress;
  List<int>? roles;

  UserRequestModel({
    this.id,
    this.phone,
    this.name,
    this.surname,
    this.cityId,
    this.districtId,
    this.gender,
    this.sendAd,
    this.birthday,
    this.email,
    this.detailAddress,
    this.roles,
  });

  factory UserRequestModel.fromJson(Map<String, dynamic> json) => _$UserRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestModelToJson(this);
}
