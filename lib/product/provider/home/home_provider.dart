import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/services/advice/advice.dart';
import 'package:rencber_mobile/product/services/weather/weather.dart';

final homeFutureProvider = FutureProvider.autoDispose(
  (ref) async {
    final weather = WeatherApiService.instance;
    final advice = AdviceApiService.instance;
    return {
      'weather': await weather.get(1).then((value) => value.data),
      'advice': await advice.get().then((value) => value.data?.where((element) => element.brand != 'Aydınlı').toList()),
    };
  },
);
