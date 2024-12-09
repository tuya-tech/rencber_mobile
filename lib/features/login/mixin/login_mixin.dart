// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/login/view/login.dart';
import 'package:rencber_mobile/product/services/login/login.dart';

mixin LoginMixin on State<LoginView> {
  late final TextEditingController phoneController;
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: "(555)");
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  bool phoneNumberValidation(String value) {
    value.replaceAll(RegExp(r'[()\s]'), '');
    if (value.isEmpty) {
      return false;
    }
    if (value.length < 10) {
      return false;
    }
    return true;
  }

  String phoneNumberFormatter(String value) {
    return value.replaceAll(RegExp(r'[()\s-]'), '');
  }

  void onLogin() async {
    if (formKey.currentState!.validate() && phoneNumberValidation(phoneController.text)) {
      appLoading(context, true);
      var firebaseToken = Platform.isAndroid
          ? FirebaseMessaging.instance.getToken()
          : Platform.isIOS
              ? FirebaseMessaging.instance.getAPNSToken()
              : null;
      var response = await LoginApiService.instance.post(phoneNumberFormatter(phoneController.text));
      if (response.statusCode == 200 && response.data != null) {
        appLoading(context, false);
        SecureStorage.instance.writeSecureData("accessToken", response.data!.accessToken!);
        SecureStorage.instance.writeSecureData("refreshToken", response.data!.refreshToken!);
        SecureStorage.instance.writeSecureData("phone", phoneNumberFormatter(phoneController.text));
        SecureStorage.instance.writeSecureData("userId", response.data!.userId.toString());
        debugPrint(response.data?.userId.toString());
        context.go(RouterManager.home);
      } else {
        appLoading(context, false);
        Toastr.showError("Giriş başarısız", context);
      }
    } else {
      Toastr.showError("Lütfen geçerli bir cep telefonu numarası giriniz.", context);
    }
  }
}
