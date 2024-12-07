import 'package:json_annotation/json_annotation.dart';
import 'package:rencber_mobile/product/models/_global/city.dart';
part '../_generated/weather/weather_response.g.dart';

@JsonSerializable(includeIfNull: false)
class WeatherResponseModel {
  final int? id;
  final bool? deleted;
  final dynamic createdBy;
  final String? createdDate;
  final dynamic lastUpdatedBy;
  final String? lastUpdatedDate;
  final CityModel? city;
  final CityModel? district;
  final int? temperature;
  final int? minTemperature;
  final int? maxTemperature;
  final int? windSpeed;
  final int? humidity;
  final String? date;
  final int? rainFall;
  final String? weatherType;

  WeatherResponseModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.createdDate,
    this.lastUpdatedBy,
    this.lastUpdatedDate,
    this.city,
    this.district,
    this.temperature,
    this.minTemperature,
    this.maxTemperature,
    this.windSpeed,
    this.humidity,
    this.date,
    this.rainFall,
    this.weatherType,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) => _$WeatherResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseModelToJson(this);
}
