// ignore_for_file: use_build_context_synchronously

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/features/splash/view/splash.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/product/provider/user/user_provider.dart';
import 'package:rencber_mobile/product/services/refresh_token/refresh_token.dart';

mixin SplashMixin on ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    checkUsers();
  }

  Future<void> checkUsers() async {
    var accessToken = await SecureStorage.instance.readSecureData("accessToken");
    var refreshToken = await SecureStorage.instance.readSecureData("refreshToken");
    var phone = await SecureStorage.instance.readSecureData("phone");
    ref.read(profileImageProvider.notifier).init();
    if (accessToken.ext.isNullOrEmpty && refreshToken.ext.isNullOrEmpty && phone.ext.isNullOrEmpty) {
      context.go(RouterManager.login);
    } else {
      if (accessToken.ext.isNotNullOrNoEmpty) {
        bool hasExpired = JwtDecoder.isExpired(accessToken ?? "");
        if (hasExpired) {
          RefreshTokenApiService.instance.post(refreshToken ?? "").then((value) {
            if (value.statusCode == 200 && value.data != null) {
              SecureStorage.instance.writeSecureData("accessToken", value.data?.accessToken ?? "");
              SecureStorage.instance.writeSecureData("refreshToken", value.data?.refreshToken ?? "");
              context.go(RouterManager.home);
            } else {
              context.go(RouterManager.login);
            }
          });
        } else {
          context.go(RouterManager.home);
        }
      }
    }
  }
}
