import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class IconManager {
  IconManager._init();
  static final IconManager instance = IconManager._init();
  Icon customIcon(IconData? icon, {Color? color, double? sizeW}) => Icon(icon, color: color, size: sizeW?.w);
}
