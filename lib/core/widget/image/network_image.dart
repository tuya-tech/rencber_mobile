import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:sizer/sizer.dart';

class AppNetworkImage {
  static Widget appNetworkImage({required String? imageUrl, required double height, required double width, BoxFit fit = BoxFit.cover}) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          memCacheHeight: 720,
          memCacheWidth: 1280,
          height: height.w,
          width: width.w,
          fit: fit,
          imageUrl: imageUrl ?? "",
          useOldImageOnUrlChange: false,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator.adaptive()),
          errorWidget: (context, url, error) => const FlutterLogo(),
        ),
      );
    } catch (e) {
      return ImageManager.instance.logo;
    }
  }

  static Widget appBase64Image({required String? base64Image, required double height, required double width, BoxFit fit = BoxFit.cover}) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          base64.decode(base64Image ?? ""),
          height: height.w,
          width: width.w,
          fit: fit,
        ),
      );
    } catch (e) {
      return ImageManager.instance.logo;
    }
  }
}
