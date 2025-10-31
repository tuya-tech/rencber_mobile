import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';

class IslemUtils {
  IslemUtils._();

  static const Map<String, Color> _colorMap = {
    'SULAMA': ColorManager.blue,
    'SIVI_GUBRELEME': ColorManager.brown,
    'KATI_GUBRELEME': ColorManager.brown,
    'CAPALAMA': ColorManager.orange,
    'ILACLAMA': ColorManager.toastrColor,
  };

static Color getMarkerColors(List selectedDay) {
    if (selectedDay.isEmpty) return ColorManager.white;
    
    if (selectedDay.contains('SULAMA')) return _colorMap['SULAMA']!;
    if (selectedDay.any((day) => day.contains('GUBRELEME'))) return _colorMap['KATI_GUBRELEME']!;
    if (selectedDay.contains('CAPALAMA')) return _colorMap['CAPALAMA']!;
    if (selectedDay.contains('ILACLAMA')) return _colorMap['ILACLAMA']!;
    
    return ColorManager.white;
  }

  static Color getIslemColor(String? code) {
    if (code == null) return ColorManager.white;
    return _colorMap[code] ?? ColorManager.white;
  }
  
  static const Map<String, String> _displayToCode = {
    'Sulama': 'SULAMA',
    'Çapalama': 'CAPALAMA',
    'Sıvı Gübreleme': 'SIVI_GUBRELEME',
    'Katı Gübreleme': 'KATI_GUBRELEME',
    'İlaçlama': 'ILACLAMA',
  };

  static const Map<String, String> _codeToDisplay = {
    'SULAMA': 'Sulama',
    'CAPALAMA': 'Çapalama',
    'SIVI_GUBRELEME': 'Sıvı Gübreleme',
    'KATI_GUBRELEME': 'Katı Gübreleme',
    'ILACLAMA': 'İlaçlama',
  };

  static String toCode(String display) => _displayToCode[display] ?? '';

  static String toDisplay(String? code, {bool capitalized = true}) {
    final val = code != null ? (_codeToDisplay[code] ?? '') : '';
    return capitalized ? val.ext.toCapitalized() : val;
  }

static String toDisplayName(String? islemTipi, {bool isCapital = false}) {
    if (islemTipi == null) return "";
    switch (islemTipi) {
      case "SULAMA":
        return "Sulama";
      case "CAPALAMA":
        return "Çapalama";
      case "SIVI_GUBRELEME":
        return isCapital ? "Gübreleme" : "sıvı gübreleme";
      case "KATI_GUBRELEME":
        return isCapital ? "Gübreleme" : "Katı gübreleme";
      case "ILACLAMA":
        return "İlaçlama";
      default:
        return "";
    }
  }
}