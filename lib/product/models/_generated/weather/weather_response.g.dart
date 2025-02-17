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
        WeatherResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.createdDate case final value?) 'createdDate': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.lastUpdatedDate case final value?) 'lastUpdatedDate': value,
      if (instance.city case final value?) 'city': value,
      if (instance.district case final value?) 'district': value,
      if (instance.temperature case final value?) 'temperature': value,
      if (instance.minTemperature case final value?) 'minTemperature': value,
      if (instance.maxTemperature case final value?) 'maxTemperature': value,
      if (instance.windSpeed case final value?) 'windSpeed': value,
      if (instance.humidity case final value?) 'humidity': value,
      if (instance.date case final value?) 'date': value,
      if (instance.rainFall case final value?) 'rainFall': value,
      if (instance.weatherType case final value?) 'weatherType': value,
    };
