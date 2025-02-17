import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppConstant {
  static String? dateFormat(BuildContext context, String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return null;
    }
    var date = DateTime.parse(dateTime).toLocal();
    return DateFormat("dd MMMM yyyy", "tr_TR").format(date);
  }

  static String setDateFormat(BuildContext context, String? dateTime) {
    dateTime ??= DateTime.now().toString();
    var date = DateTime.parse(dateTime).toLocal();
    return DateFormat("yyyy-MM-dd", context.locale.languageCode).format(date);
  }

  static String setDateTimeFormat(BuildContext context, String pattern, String? dateTime) {
    dateTime ??= DateTime.now().toString();
    var date = DateTime.parse(dateTime).toLocal();
    return DateFormat(pattern, context.locale.languageCode).format(date);
  }
}
