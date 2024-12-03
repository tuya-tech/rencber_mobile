import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/services/weather/weather.dart';

final homeFutureProvider = FutureProvider.autoDispose(
  (ref) async {
    final weather = WeatherApiService.instance;
    return {
      'weather': await weather.get(1),
    };
  },
);
