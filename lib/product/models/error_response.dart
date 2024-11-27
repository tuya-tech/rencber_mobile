import 'package:json_annotation/json_annotation.dart';
part '_generated/error_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ErrorResponseModel<T> {
  final String? code;
  final List<String>? parameters;

  const ErrorResponseModel({
    this.code,
    this.parameters,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => _$ErrorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseModelToJson(this);
}
