import 'package:json_annotation/json_annotation.dart';
part '_generated/error_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ErrorResponseModel {
  final String? code;
  final List<String>? parameters;
  final String? validationErrors;

  const ErrorResponseModel({
    this.code,
    this.parameters,
    this.validationErrors,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => _$ErrorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseModelToJson(this);
}
