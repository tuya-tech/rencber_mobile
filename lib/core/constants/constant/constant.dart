import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppConstant {
  // Date format patterns
  static const String defaultDatePattern = "dd MMMM yyyy";
  static const String apiDatePattern = "yyyy-MM-dd";
  static const String dottedDatePattern = "dd.MM.yyyy";
  static const String turkishLocale = "tr_TR";
  
  // API Constants
  static const String defaultErrorMessage = "Bir hata oluştu";
  static const String networkErrorMessage = "Bağlantı hatası oluştu";
  static const String timeoutErrorMessage = "İşlem zaman aşımına uğradı";
  
  static String? dateFormat(BuildContext context, String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return null;
    }
    
    try {
      final date = DateTime.parse(dateTime).toLocal();
      return DateFormat(defaultDatePattern, turkishLocale).format(date);
    } catch (e) {
      debugPrint('Date parsing error: $e');
      return dateTime; // Return original if parsing fails
    }
  }

  static String setDateFormat(BuildContext context, String? dateTime) {
    try {
      final dateTimeValue = dateTime ?? DateTime.now().toIso8601String();
      final date = DateTime.parse(dateTimeValue).toLocal();
      return DateFormat(apiDatePattern, context.locale.languageCode).format(date);
    } catch (e) {
      debugPrint('Date formatting error: $e');
      return DateTime.now().toIso8601String().split('T').first;
    }
  }

  static String setDateTimeFormat(BuildContext context, String pattern, String? dateTime) {
    try {
      final dateTimeValue = dateTime ?? DateTime.now().toIso8601String();
      final date = DateTime.parse(dateTimeValue).toLocal();
      return DateFormat(pattern, context.locale.languageCode).format(date);
    } catch (e) {
      debugPrint('DateTime formatting error: $e');
      return dateTime ?? '';
    }
  }

  static String convertDottedDateToText(String dateStr) {
    try {
      final date = DateFormat(dottedDatePattern).parse(dateStr);
      return DateFormat(defaultDatePattern, turkishLocale).format(date);
    } catch (e) {
      debugPrint('Dotted date conversion error: $e');
      return dateStr;
    }
  }

  static String convertDottedDateToText2(String dateStr, BuildContext context) {
    try {
      final date = DateFormat(dottedDatePattern).parse(dateStr);
      return DateFormat(apiDatePattern, context.locale.languageCode).format(date);
    } catch (e) {
      debugPrint('Dotted date to API format conversion error: $e');
      return dateStr;
    }
  }

  // Helper method to check if a string is a valid date
  static bool isValidDate(String dateStr, {String pattern = "yyyy-MM-dd"}) {
    try {
      DateFormat(pattern).parseStrict(dateStr);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Helper method to get current date in API format
  static String getCurrentDateForApi() {
    return DateFormat(apiDatePattern).format(DateTime.now());
  }
}
