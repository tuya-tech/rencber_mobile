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
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : CityModel.fromJson(json['district'] as Map<String, dynamic>),
      timezone: (json['timezone'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      date: json['date'] as String?,
      sunrise: json['sunrise'] as String?,
      sunset: json['sunset'] as String?,
      tempDay: (json['tempDay'] as num?)?.toDouble(),
      tempMin: (json['tempMin'] as num?)?.toDouble(),
      tempMax: (json['tempMax'] as num?)?.toDouble(),
      tempNight: (json['tempNight'] as num?)?.toDouble(),
      tempEve: (json['tempEve'] as num?)?.toDouble(),
      tempMorn: (json['tempMorn'] as num?)?.toDouble(),
      feelsLikeDay: (json['feelsLikeDay'] as num?)?.toDouble(),
      feelsLikeNight: (json['feelsLikeNight'] as num?)?.toDouble(),
      feelsLikeEve: (json['feelsLikeEve'] as num?)?.toDouble(),
      feelsLikeMorn: (json['feelsLikeMorn'] as num?)?.toDouble(),
      weatherMain: json['weatherMain'] as String?,
      weatherDescription: json['weatherDescription'] as String?,
      weatherIcon: json['weatherIcon'] as String?,
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      windSpeed: (json['windSpeed'] as num?)?.toDouble(),
      windDeg: (json['windDeg'] as num?)?.toDouble(),
      windGust: (json['windGust'] as num?)?.toDouble(),
      cloudiness: (json['cloudiness'] as num?)?.toDouble(),
      pop: (json['pop'] as num?)?.toDouble(),
      rain: (json['rain'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherResponseModelToJson(
        WeatherResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.city case final value?) 'city': value,
      if (instance.district case final value?) 'district': value,
      if (instance.timezone case final value?) 'timezone': value,
      if (instance.lon case final value?) 'lon': value,
      if (instance.lat case final value?) 'lat': value,
      if (instance.date case final value?) 'date': value,
      if (instance.sunrise case final value?) 'sunrise': value,
      if (instance.sunset case final value?) 'sunset': value,
      if (instance.tempDay case final value?) 'tempDay': value,
      if (instance.tempMin case final value?) 'tempMin': value,
      if (instance.tempMax case final value?) 'tempMax': value,
      if (instance.tempNight case final value?) 'tempNight': value,
      if (instance.tempEve case final value?) 'tempEve': value,
      if (instance.tempMorn case final value?) 'tempMorn': value,
      if (instance.feelsLikeDay case final value?) 'feelsLikeDay': value,
      if (instance.feelsLikeNight case final value?) 'feelsLikeNight': value,
      if (instance.feelsLikeEve case final value?) 'feelsLikeEve': value,
      if (instance.feelsLikeMorn case final value?) 'feelsLikeMorn': value,
      if (instance.weatherMain case final value?) 'weatherMain': value,
      if (instance.weatherDescription case final value?)
        'weatherDescription': value,
      if (instance.weatherIcon case final value?) 'weatherIcon': value,
      if (instance.pressure case final value?) 'pressure': value,
      if (instance.humidity case final value?) 'humidity': value,
      if (instance.windSpeed case final value?) 'windSpeed': value,
      if (instance.windDeg case final value?) 'windDeg': value,
      if (instance.windGust case final value?) 'windGust': value,
      if (instance.cloudiness case final value?) 'cloudiness': value,
      if (instance.pop case final value?) 'pop': value,
      if (instance.rain case final value?) 'rain': value,
    };
