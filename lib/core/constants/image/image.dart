import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class ImageManager {
  ImageManager._();
  static final instance = ImageManager._();

  static const String _logo = "assets/logo.svg";
  static const String _splashBg = "assets/splashBg.png";
  static const String _trFlag = "assets/trFlag.svg";
}

extension ImageManagerExtension on ImageManager {
  Widget get logo => SvgPicture.asset(ImageManager._logo);
  Widget get splashBg => Image.asset(ImageManager._splashBg, height: 100.h, width: 100.w, fit: BoxFit.cover);
  Widget get trFlag => SvgPicture.asset(ImageManager._trFlag);
}
