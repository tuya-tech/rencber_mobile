import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/login/view/login.dart';

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

  void onLogin() {
    if (formKey.currentState!.validate() && phoneNumberValidation(phoneController.text)) {
      debugPrint("Login success ${phoneController.text}");
    } else {
      Toastr.showError("Lütfen geçerli bir cep telefonu numarası giriniz.", context);
      debugPrint("Login failed");
    }
  }
}
