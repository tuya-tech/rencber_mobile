import 'package:json_annotation/json_annotation.dart';
part '_generated/base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false)
class BaseResponseModel<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final String? errorCode;

  const BaseResponseModel({
    this.data,
    this.message,
    this.statusCode,
    this.errorCode,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) => BaseResponseModel(
        data: json["data"],
        message: json["message"],
        statusCode: json["statusCode"],
        errorCode: json["errorCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "statusCode": statusCode,
        "errorCode": errorCode,
      };
}
