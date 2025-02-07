// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../weather/weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponseModel _$WeatherResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherResponseModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'],
      createdDate: json['createdDate'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'],
      lastUpdatedDate: json['lastUpdatedDate'] as String?,
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : CityModel.fromJson(json['district'] as Map<String, dynamic>),
      temperature: (json['temperature'] as num?)?.toDouble(),
      minTemperature: (json['minTemperature'] as num?)?.toDouble(),
      maxTemperature: (json['maxTemperature'] as num?)?.toDouble(),
      windSpeed: (json['windSpeed'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      date: json['date'] as String?,
      rainFall: (json['rainFall'] as num?)?.toDouble(),
      weatherType: json['weatherType'] as String?,
    );

Map<String, dynamic> _$WeatherResponseModelToJson(
    WeatherResponseModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('deleted', instance.deleted);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('createdDate', instance.createdDate);
  writeNotNull('lastUpdatedBy', instance.lastUpdatedBy);
  writeNotNull('lastUpdatedDate', instance.lastUpdatedDate);
  writeNotNull('city', instance.city);
  writeNotNull('district', instance.district);
  writeNotNull('temperature', instance.temperature);
  writeNotNull('minTemperature', instance.minTemperature);
  writeNotNull('maxTemperature', instance.maxTemperature);
  writeNotNull('windSpeed', instance.windSpeed);
  writeNotNull('humidity', instance.humidity);
  writeNotNull('date', instance.date);
  writeNotNull('rainFall', instance.rainFall);
  writeNotNull('weatherType', instance.weatherType);
  return val;
}
