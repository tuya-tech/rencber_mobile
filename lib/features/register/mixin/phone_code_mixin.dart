import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rencber_mobile/features/register/view/phone_code.dart';

mixin PhoneCodeMixin on State<PhoneCodeView> {
  late final TextEditingController phoneCodeController;
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    phoneCodeController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneCodeController.dispose();
  }
}
