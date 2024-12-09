import 'package:json_annotation/json_annotation.dart';
part '../_generated/login/login_response.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginResponseModel {
  int? userId;
  String? accessToken;
  String? refreshToken;

  LoginResponseModel({
    this.userId,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
