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

  static Widget weatherImage(String weatherType) {
    weatherType = weatherType.toLowerCase().ext.toCapitalized();
    return Image.asset("assets/weather/$weatherType.png", height: 12.w, width: 12.w);
    // switch (weatherType) {
    //   case "Clear":
    //     return Image.asset("assets/weather/clear.png");
    //   case "Clouds":
    //     return Image.asset("assets/weather/clouds.png");
    //   case "Rain":
    //     return Image.asset("assets/weather/rain.png");
    //   case "Snow":
    //     return Image.asset("assets/weather/snow.png");
    //   case "Thunderstorm":
    //     return Image.asset("assets/weather/thunderstorm.png");
    //   case "Sunny":
    //     return Image.asset("assets/weather/sunny.png");
    //   default:
    //     return Image.asset("assets/weather/clear.png");
    // }
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
}
