import 'package:json_annotation/json_annotation.dart';
import 'package:rencber_mobile/product/models/_global/city.dart';
part '../_generated/weather/weather_response.g.dart';

@JsonSerializable(includeIfNull: false)
class WeatherResponseModel {
  final int? id;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;
  final CityModel? city;
  final CityModel? district;
  final double? timezone;
  final double? lon;
  final double? lat;
  final String? date;
  final String? sunrise;
  final String? sunset;
  final double? tempDay;
  final double? tempMin;
  final double? tempMax;
  final double? tempNight;
  final double? tempEve;
  final double? tempMorn;
  final double? feelsLikeDay;
  final double? feelsLikeNight;
  final double? feelsLikeEve;
  final double? feelsLikeMorn;
  final String? weatherMain;
  final String? weatherDescription;
  final String? weatherIcon;
  final double? pressure;
  final double? humidity;
  final double? windSpeed;
  final double? windDeg;
  final double? windGust;
  final double? cloudiness;
  final double? pop;
  final double? rain;

  WeatherResponseModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
    this.city,
    this.district,
    this.timezone,
    this.lon,
    this.lat,
    this.date,
    this.sunrise,
    this.sunset,
    this.tempDay,
    this.tempMin,
    this.tempMax,
    this.tempNight,
    this.tempEve,
    this.tempMorn,
    this.feelsLikeDay,
    this.feelsLikeNight,
    this.feelsLikeEve,
    this.feelsLikeMorn,
    this.weatherMain,
    this.weatherDescription,
    this.weatherIcon,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.cloudiness,
    this.pop,
    this.rain,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) => _$WeatherResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseModelToJson(this);
}
