import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/product/models/_global/city.dart';
import 'package:rencber_mobile/product/services/location/location_response.dart';
import 'package:kartal/kartal.dart';

final cityFutureProvider = FutureProvider<List<dynamic>>(
  (ref) async {
    debugPrint("cityFutureProvider");
    //List<dynamic> isCacheData = await SecureStorage.instance.readListSecureData("cacheCityList");
    //if (isCacheData.isEmpty) {
    final city = LocationApiService.instance;
    var cacheData = await city.cityGet();
    debugPrint("cacheData: $cacheData");
    cacheData.data?.sort((a, b) => a.id!.compareTo(b.id!));
    return cacheData.data ?? [];
    //await SecureStorage.instance.writeListSecureData("cacheCityList", cacheData ?? []);
    //return await SecureStorage.instance.readListSecureData("cacheCityList");
    // } else {
    //   debugPrint("isCacheData: $isCacheData");
    //   return isCacheData;
    // }
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
