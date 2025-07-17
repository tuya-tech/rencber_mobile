// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/valide/view/valide_code.dart';
import 'package:rencber_mobile/product/services/login/login.dart';
import 'package:rencber_mobile/product/services/valide_code/valide_code.dart';

mixin ValideCodeMixin on State<ValideCodeView> {
  late final TextEditingController valideCodeController;
  final formKey = GlobalKey<FormBuilderState>();
  late Timer timer;
  int second = 60 * 4;

  @override
  void initState() {
    super.initState();
    valideCodeController = TextEditingController();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (second == 0) {
        timer.cancel();
      } else {
        setState(() {
          second--;
        });
      }
    });
  }

  String phoneNumberFormatter(String value) {
    return value.replaceAll(RegExp(r'[()\s-]'), '');
  }

  void onValide() async {
    debugPrint(valideCodeController.text);
    debugPrint(phoneNumberFormatter(widget.phoneNumber));
    if (formKey.currentState!.validate()) {
      appLoading(context, true);
      var valideCode = valideCodeController.text;
      var firebaseToken = Platform.isAndroid
          ? await FirebaseMessaging.instance.getToken()
          : Platform.isIOS || Platform.isMacOS
              ? await FirebaseMessaging.instance.getAPNSToken()
              : "";
      debugPrint("firebaseToken : $firebaseToken");
      var response = await ValideCodeApiService.instance.post(valideCode, phoneNumberFormatter(widget.phoneNumber));
      debugPrint(response.data.toString());
      
      appLoading(context, false);
      
      // CODE-1003 (validCode) hatasını özel olarak handle et
      if (response.message?.contains("CODE-1003") == true) {
        Toastr.showError(response.message ?? "Kod geçerli", context);
        // Kod girme ekranında kal, kullanıcının tekrar deneme yapmasına izin ver
        valideCodeController.clear();
        return;
      }
      
      if (response.data != null) {
        var loginResponse = await LoginApiService.instance.login(phoneNumberFormatter(widget.phoneNumber), valideCode, firebaseToken ?? "");
        if (loginResponse.statusCode == 200 && loginResponse.data?.accessToken != null) {
          SecureStorage.instance.writeSecureData("accessToken", loginResponse.data!.accessToken!);
          SecureStorage.instance.writeSecureData("refreshToken", loginResponse.data!.refreshToken!);
          SecureStorage.instance.writeSecureData("phone", phoneNumberFormatter(widget.phoneNumber));
          SecureStorage.instance.writeSecureData("userId", loginResponse.data!.userId.toString());
          context.go(RouterManager.home);
        } else {
          // Login sırasında da CODE-1003 kontrolü
          if (loginResponse.message?.contains("CODE-1003") == true) {
            Toastr.showError(loginResponse.message ?? "Kod geçerli, tekrar deneyiniz", context);
            valideCodeController.clear();
          } else {
            Toastr.showError(loginResponse.message ?? "Giriş başarısız", context);
          }
        }
      } else {
        Toastr.showError(response.message ?? "Kod hatalı", context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    valideCodeController.dispose();
  }
}
