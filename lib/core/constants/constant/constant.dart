import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppConstant {
  static String dateFormat(BuildContext context, String? dateTime) {
    debugPrint("dateTime: $dateTime");
    dateTime ??= DateTime.now().toString();
    var date = DateTime.parse(dateTime).toLocal();
    return DateFormat("dd MMMM yyyy", context.locale.languageCode).format(date);
  }
}
