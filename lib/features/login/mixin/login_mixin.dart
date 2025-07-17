// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/utils/validators.dart';
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
    phoneController = TextEditingController(text: "(0)");
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void onLogin() async {
    debugPrint(AppValidators.formatPhoneNumber(phoneController.text));
    if (formKey.currentState!.validate() && AppValidators.isValidPhoneNumber(phoneController.text)) {
      appLoading(context, true);
      var response = await LoginApiService.instance.loginRequest(AppValidators.formatPhoneNumber(phoneController.text));
      debugPrint(response.data.toString());
      appLoading(context, false);
      
      if (response.statusCode == 200 && response.data == true) {
        context.push(RouterManager.phoneCode, extra: AppValidators.formatPhoneNumber(phoneController.text));
      } else {
        // CODE-1003 hatasını özel olarak handle et
        if (response.message?.contains("CODE-1003") == true) {
          // Kod geçerli, telefon kodu doğrulama ekranına yönlendir
          context.push(RouterManager.phoneCode, extra: AppValidators.formatPhoneNumber(phoneController.text));
        } else {
          // Diğer hatalar için hata mesajı göster
          Toastr.showError(response.message ?? "Giriş isteği gönderilemedi", context);
        }
      }
    } else {
      Toastr.showError(AppValidators.getPhoneNumberError(), context);
    }
  }
}
