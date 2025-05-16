import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/weather/weather_response.dart';
import 'package:rencber_mobile/product/services/weather/weather.dart';

final weatherFutureProvider = FutureProvider.autoDispose<BaseResponseModel<List<WeatherResponseModel>>>(
  (ref) async {
    return WeatherApiService.instance.getAll();
  },
);
