// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
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
    debugPrint(phoneNumberFormatter(phoneController.text));
    if (formKey.currentState!.validate() && phoneNumberValidation(phoneController.text)) {
      appLoading(context, true);
      var response = await LoginApiService.instance.loginRequest(phoneNumberFormatter(phoneController.text));
      debugPrint(response.data.toString());
      if (response.data != null) {
        appLoading(context, false);
        context.push(RouterManager.phoneCode, extra: phoneNumberFormatter(phoneController.text));
      } else {
        appLoading(context, false);
        context.push(RouterManager.phoneCode, extra: phoneNumberFormatter(phoneController.text));
      }
    } else {
      Toastr.showError("Lütfen geçerli bir cep telefonu numarası giriniz.", context);
    }
  }
}
