import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:sizer/sizer.dart';

class ToastrMsg {
  ToastrMsg._();
  static final instance = ToastrMsg._();
  bool _isToastShown = false;
  bool isErrorCode = false;

  void toastMsg(BuildContext context, String message, {bool isError = false, String? errorCode}) {
    if (_isToastShown == false) {
      _isToastShown = true;
      FToast fToast = FToast();
      fToast.init(context);
      fToast.showToast(
        positionedToastBuilder: (context, child, gravity) {
          return Positioned(top: 12.w, left: 10.w, right: 10.w, child: child);
        },
        child: SizedBox(
          width: 100.w,
          child: Card(
            color: ColorManager.WHITE,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: context.padding.normal,
              child: isError
                  ? Row(
                      children: [
                        IconManager.instance.customIcon(Icons.warning_amber_outlined, color: ColorManager.RED, sizeW: 8),
                        context.sized.emptySizedWidthBoxLow3x,
                        Expanded(child: Text(message, style: context.general.textTheme.labelLarge)),
                      ],
                    )
                  : Row(
                      children: [
                        IconManager.instance.customIcon(Icons.check_box, color: ColorManager.TOASTRCOLOR, sizeW: 8),
                        context.sized.emptySizedWidthBoxLow3x,
                        Expanded(child: Text(message, style: context.general.textTheme.labelLarge)),
                      ],
                    ),
            ),
          ),
        ),
        toastDuration: const Duration(seconds: 3),
      );
      Future.delayed(const Duration(seconds: 3), () {
        _isToastShown = false;
      });
    }
  }
}

class Toastr {
  static showSuccess(String message, BuildContext context) {
    ToastrMsg.instance.toastMsg(context, message, isError: false);
  }

  static showError(String message, BuildContext context, {String? errorCode}) {
    ToastrMsg.instance.toastMsg(context, message, isError: true, errorCode: errorCode);
  }
}
