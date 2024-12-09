import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/product/models/_global/city.dart';
import 'package:rencber_mobile/product/services/location/location_response.dart';
import 'package:kartal/kartal.dart';

final cityFutureProvider = FutureProvider<List<dynamic>>(
  (ref) async {
    List<dynamic> isCacheData = await SecureStorage.instance.readListSecureData("cacheCityList");
    if (isCacheData.ext.isNullOrEmpty) {
      final city = LocationApiService.instance;
      var cacheData = await city.cityGet().then((value) => value.data);
      cacheData?.sort((a, b) => a.id!.compareTo(b.id!));
      await SecureStorage.instance.writeListSecureData("cacheCityList", cacheData ?? []);
      return await SecureStorage.instance.readListSecureData("cacheCityList");
    } else {
      return isCacheData;
    }
  },
);

final districtFutureProvider = FutureProvider.family<List<CityModel>, int>(
  (ref, cityId) async {
    final district = LocationApiService.instance;
    var districtData = await district.districtGet(cityId);
    districtData.data?.sort((a, b) => a.id!.compareTo(b.id!));
    return districtData.data ?? [];
  },
);

final selectedCityIdProvider = StateNotifierProvider(
  (ref) {
    return SelectedCityIdStateNotifier();
  },
);

class SelectedCityIdStateNotifier extends StateNotifier<int> {
  SelectedCityIdStateNotifier() : super(0);

  void notify(int index) async {
    
    state = index;
  }
}
