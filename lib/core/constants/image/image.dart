import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:kartal/kartal.dart';

class ImageManager {
  ImageManager._();
  static final instance = ImageManager._();

  static const String _logo = "assets/logo.svg";
  static const String _splashBg = "assets/splashBg.png";
  static const String _appbar = "assets/appbar.png";
  static const String _appbarRightLogo = "assets/appbarRightLogo.png";
  static const String _trFlag = "assets/trFlag.svg";
  static const String _tarla = "assets/tarla.png";
  static const String _rainFall = "assets/weather/rainFall.png";
  static const String _windFall = "assets/weather/windFall.png";
  static const String _humanityFall = "assets/weather/humanityFall.png";
  static const String _women = "assets/kadin.png";
  static const String _rightArrow = "assets/rightArrow.png";
  static const String _evre = "assets/evreicon.png";
  static const String _sulama = "assets/islemler/sulama.png";
  static const String _capalama = "assets/islemler/capalama.png";
  static const String _gubreleme = "assets/islemler/gubreleme.png";
  static const String _men = "assets/men.png";

  static Image getMenuImage(String imageName) {
    return Image.asset("assets/navigation/$imageName.png", height: 15.w, width: 15.w);
  }

  static Widget weatherImage(String weatherType) {
    weatherType = weatherType.toLowerCase().ext.toCapitalized();
    //return Image.asset("assets/weather/$weatherType.png", height: 12.w, width: 12.w);
    switch (weatherType) {
      case "Clear":
        return Image.asset("assets/weather/Clear.png", height: 12.w, width: 12.w);
      case "Clouds":
      case "Mist":
      case "Haze":
      case "Fog":
      case "Smoke":
      case "Dust":
      case "Sand":
      case "Ash":
        return Image.asset("assets/weather/Clouds.png", height: 12.w, width: 12.w);
      case "Rain":
      case "Drizzle":
        return Image.asset("assets/weather/Rain.png", height: 12.w, width: 12.w);
      case "Snow":
        return Image.asset("assets/weather/Snow.png", height: 12.w, width: 12.w);
      case "Thunderstorm":
      case "Squall":
      case "Tornado":
        return Image.asset("assets/weather/Thunderstorm.png", height: 12.w, width: 12.w);
      default:
        return Image.asset("assets/weather/Clear.png", height: 12.w, width: 12.w);
    }
  }
}

extension ImageManagerExtension on ImageManager {
  Widget get logo => SvgPicture.asset(ImageManager._logo);
  Widget get splashBg => Image.asset(ImageManager._splashBg, height: 100.h, width: 100.w, fit: BoxFit.cover);
  Widget get appbar => Image.asset(ImageManager._appbar, height: 100.h, width: 100.w, fit: BoxFit.cover, colorBlendMode: BlendMode.color);
  Widget get appbarRightLogo => Image.asset(ImageManager._appbarRightLogo);
  Widget get tarla => Image.asset(ImageManager._tarla);
  Widget get trFlag => SvgPicture.asset(ImageManager._trFlag);
  Widget get rainFall => Image.asset(ImageManager._rainFall, height: 6.w, width: 6.w, fit: BoxFit.cover);
  Widget get windFall => Image.asset(ImageManager._windFall, height: 6.w, width: 6.w, fit: BoxFit.cover);
  Widget get humanityFall => Image.asset(ImageManager._humanityFall, height: 6.w, width: 6.w, fit: BoxFit.cover);
  Widget get women => Image.asset(ImageManager._women, height: 25.w, width: 25.w, fit: BoxFit.cover);
  Widget get men => Image.asset(ImageManager._men, height: 25.w, width: 25.w, fit: BoxFit.cover);
  Widget get rightArrow => Image.asset(ImageManager._rightArrow, height: 6.w, width: 6.w);
  Widget get evre => Image.asset(ImageManager._evre, height: 3.5.w, width: 3.5.w);
  Widget get sulama => Image.asset(ImageManager._sulama, height: 12.w, width: 12.w);
  Widget get capalama => Image.asset(ImageManager._capalama, height: 12.w, width: 12.w);
  Widget get gubreleme => Image.asset(ImageManager._gubreleme, height: 12.w, width: 12.w);
}
