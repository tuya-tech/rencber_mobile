import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/button/right_icon_button.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/advice/mixin/advice_mixin.dart';
import 'package:rencber_mobile/product/provider/advice/advice_provider.dart';
import 'package:sizer/sizer.dart';

class AdviceView extends ConsumerStatefulWidget {
  const AdviceView({super.key});

  @override
  ConsumerState<AdviceView> createState() => _AdviceViewState();
}

class _AdviceViewState extends ConsumerState<AdviceView> with AdviceMixin {
  @override
  Widget build(BuildContext context) {
    var adviceProvider = ref.watch(adviceFutureProvider);
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: adviceProvider.when(
        data: (adviceData) {
          var (outLineData, normalData) = outLineAndNormalData(adviceData.data ?? []);
          return SliverAppBarCustom(
            height: 15,
            title: Text("Tavsiyeler", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
            child: Padding(
              padding: context.padding.low,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Aydınlı Biyoteknoloji A.Ş", style: context.general.textTheme.titleSmall),
                      AppRightIconButton(
                        onPressed: () => context.push(RouterManager.brandList, extra: outLineData),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 45.w,
                    width: 100.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      //padding: context.padding.onlyLeftNormal + context.padding.onlyBottomNormal,
                      itemCount: outLineData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 45.w,
                          width: 75.w,
                          child: Card(
                            color: ColorManager.white,
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.w, right: 1.w, top: 2.w, bottom: 2.w),
                              child: Row(
                                children: [
                                  AppNetworkImage.appNetworkImage(imageUrl: outLineData[index].image, height: 33, width: 33),
                                  context.sized.emptySizedWidthBoxLow3x,
                                  Expanded(
                                    child: Padding(
                                      padding: context.padding.verticalLow,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text(outLineData[index].title ?? "", maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.titleSmall)),
                                          Expanded(child: Text(outLineData[index].summary ?? "", maxLines: 3, overflow: TextOverflow.ellipsis, style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.black.withValues(alpha: 0.7)))),
                                          context.sized.emptySizedHeightBoxLow,
                                          AppElevetedButton(
                                            buttonText: "İncele",
                                            buttonwidth: 22,
                                            buttonHeight: 7,
                                            textStyle: context.general.textTheme.bodyLarge?.copyWith(color: ColorManager.white, fontSize: 13.sp),
                                            onPressed: () => context.push(RouterManager.brandDetails, extra: outLineData[index].id),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: context.padding.onlyLeftNormal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Size Özel Öneriler", style: context.general.textTheme.titleSmall),
                        AppRightIconButton(
                          onPressed: () => context.push(RouterManager.advices, extra: normalData),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60.w,
                    width: 100.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      //padding: context.padding.onlyLeftNormal + context.padding.onlyBottomNormal,
                      itemCount: normalData.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 60.w,
                          width: 40.w,
                          child: Card(
                            color: ColorManager.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppNetworkImage.appNetworkImage(imageUrl: normalData[index].image, height: 25, width: 25),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: context.padding.horizontalNormal,
                                    child: Text(normalData[index].title ?? "", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.greyColor)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => context.push(RouterManager.adviceDetails, extra: normalData[index].id),
                                  child: Padding(
                                    padding: context.padding.onlyRightNormal,
                                    child: Align(alignment: Alignment.bottomRight, child: ImageManager.instance.rightArrow),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          debugPrint("Error: $error");

          // Hata mesajını toast olarak göster
          WidgetsBinding.instance.addPostFrameCallback((_) {
            String errorMessage = "Tavsiye verileri yüklenirken hata oluştu";

            // Eğer hata string ise ve backend hata kodu içeriyorsa işle
            if (error is String) {
              errorMessage = ExceptionHandler.handleException(error);
            }

            Toastr.showError(errorMessage, context);
          });
          return null;
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
