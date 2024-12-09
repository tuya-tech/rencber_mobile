import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/user/user_response.dart';
import 'package:rencber_mobile/product/services/user/user.dart';

final userIdFutureProvider = FutureProvider.autoDispose<BaseResponseModel<UserResponseModel>>(
  (ref) async {
    var userId = await SecureStorage.instance.readSecureData("userId");
    return UserApiService.instance.getById(int.tryParse(userId ?? "0") ?? 0);
  },
);
