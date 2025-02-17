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
      if (response.data != null) {
        var response = await LoginApiService.instance.login(phoneNumberFormatter(widget.phoneNumber), valideCode, firebaseToken ?? "");
        if (response.statusCode == 200 && response.data != null) {
          appLoading(context, false);
          SecureStorage.instance.writeSecureData("accessToken", response.data!.accessToken!);
          SecureStorage.instance.writeSecureData("refreshToken", response.data!.refreshToken!);
          SecureStorage.instance.writeSecureData("phone", phoneNumberFormatter(widget.phoneNumber));
          SecureStorage.instance.writeSecureData("userId", response.data!.userId.toString());
          context.go(RouterManager.home);
        } else {
          appLoading(context, false);
          Toastr.showError("Giriş başarısız", context);
        }
      } else {
        appLoading(context, false);
        Toastr.showError("Kod hatalı", context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    valideCodeController.dispose();
  }
}
