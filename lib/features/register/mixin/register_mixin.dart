import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

mixin RegisterMixin<T extends StatefulWidget> on State<T> {
  late final TextEditingController phoneController;
  late final TextEditingController nameSurnameController;
  late final TextEditingController cityController;
  late final TextEditingController districtController;
  final formKey = GlobalKey<FormBuilderState>();
  String? gender;
  List<bool> checkBoxValue = [false, false];

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: "(555)");
    nameSurnameController = TextEditingController();
    cityController = TextEditingController();
    districtController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameSurnameController.dispose();
    cityController.dispose();
    districtController.dispose();
  }

  void setGender(String value) {
    gender = value;
  }

  void setChechBoxValue(List<bool> value) {
    checkBoxValue = value;
  }
}
