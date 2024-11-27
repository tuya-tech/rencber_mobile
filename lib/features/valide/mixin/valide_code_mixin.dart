// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/valide/view/valide_code.dart';
import 'package:rencber_mobile/product/services/valide_code/valide_code.dart';

mixin ValideCodeMixin on State<ValideCodeView> {
  late final TextEditingController valideCodeController;
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    valideCodeController = TextEditingController(text: "123456");
  }

  void onValide() {
    if (formKey.currentState!.validate()) {
      var valideCode = valideCodeController.text;
      if (valideCode == "123456") {
        ValideCodeApiService.instance.post(valideCode, 1).then((value) {
          if (value.statusCode == 200) {
            context.go(RouterManager.login);
          } else {
            Toastr.showError("Kod hatalı", context);
          }
        });
      } else {
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
