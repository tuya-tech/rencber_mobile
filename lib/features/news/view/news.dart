import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/card/blur_card.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/news/mixin/news_mixin.dart';
import 'package:rencber_mobile/product/provider/news/news_provider.dart';
import 'package:sizer/sizer.dart';

class NewsView extends ConsumerStatefulWidget {
  const NewsView({super.key});

  @override
  ConsumerState<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends ConsumerState<NewsView> with NewsMixin {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final double itemWidth = 80.w;
      final double offset = _scrollController.offset;
      setState(() {
        _currentIndex = (offset / itemWidth).round() % 4; // Mod 4 to loop back
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var newsProvider = ref.watch(newsFutureProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.bgColor,
      body: newsProvider.when(data: (newsData) {
        var (outLineData, normalData) = outLineAndNormalData(newsData.data ?? []);
        return SliverAppBarCustom(
          height: 55,
          title: Text("Haberler", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
          appbarChild: Padding(
            padding: context.padding.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: context.padding.onlyLeftNormal, child: Text("Öne Çıkanlar", style: context.general.textTheme.titleSmall?.copyWith(color: ColorManager.white))),
                SizedBox(
                  height: 40.w,
                  width: 100.w,
                  child: ListView.builder(
                    controller: _scrollController,
                    //physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: outLineData.length,
                    itemBuilder: (context, index) {
                      return BlurCard(
                        onTap: () => context.push(RouterManager.newsDetails, extra: outLineData[index].id),
                        height: 40,
                        width: 80,
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 1.w, top: 1.w),
                          child: Row(
                            children: [
                              AppNetworkImage.appNetworkImage(imageUrl: outLineData[index].image, height: 30, width: 30),
                              context.sized.emptySizedWidthBoxLow3x,
                              Expanded(
                                child: Padding(
                                  padding: context.padding.verticalLow,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(outLineData[index].title ?? "", maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.titleSmall?.copyWith(color: ColorManager.white)),
                                      Text(outLineData[index].summary ?? "", maxLines: 3, overflow: TextOverflow.ellipsis, style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.white.withValues(alpha: 0.7))),
                                      Row(
                                        children: [
                                          IconManager.instance.customIcon(Icons.calendar_month_outlined, color: ColorManager.buttonBgGreen),
                                          context.sized.emptySizedWidthBoxLow,
                                          Text(AppConstant.dateFormat(context, outLineData[index].date) ?? "", style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.textGreyColor)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: context.padding.onlyBottomLow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4, // Always show 4 dots
                      (index) {
                        return Container(
                          width: _currentIndex == index ? 2.w : 1.5.w,
                          height: 2.3.w,
                          margin: EdgeInsets.symmetric(vertical: 1.w, horizontal: 1.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: _currentIndex == index ? ColorManager.white : ColorManager.greyColor),
                            color: _currentIndex == index ? ColorManager.white : ColorManager.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: context.padding.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gündem", style: context.general.textTheme.titleSmall),
                context.sized.emptySizedHeightBoxLow,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: context.padding.onlyBottomNormal,
                  itemCount: normalData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => context.push(RouterManager.newsDetails, extra: normalData[index].id),
                      child: Card(
                        color: ColorManager.white,
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 1.w, top: 2.w, bottom: 2.w),
                          child: Row(
                            children: [
                              AppNetworkImage.appNetworkImage(imageUrl: normalData[index].image, height: 30, width: 30),
                              context.sized.emptySizedWidthBoxLow3x,
                              Expanded(
                                child: Padding(
                                  padding: context.padding.verticalLow,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(normalData[index].title ?? "", maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.titleSmall),
                                      Text(normalData[index].summary ?? "", maxLines: 3, overflow: TextOverflow.ellipsis, style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.black.withValues(alpha: 0.7))),
                                      context.sized.emptySizedHeightBoxLow,
                                      Row(
                                        children: [
                                          IconManager.instance.customIcon(Icons.calendar_month_outlined, color: ColorManager.buttonBgGreen),
                                          context.sized.emptySizedWidthBoxLow,
                                          Text(AppConstant.dateFormat(context, normalData[index].date) ?? "", style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.textGreyColor)),
                                        ],
                                      ),
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
              ],
            ),
          ),
        );
      }, error: (error, stackTrace) {
        debugPrint("Error: $error");

        // Hata mesajını toast olarak göster
        WidgetsBinding.instance.addPostFrameCallback((_) {
          String errorMessage = "Haber verileri yüklenirken hata oluştu";

          // Eğer hata string ise ve backend hata kodu içeriyorsa işle
          if (error is String) {
            errorMessage = ExceptionHandler.handleException(error);
          }

          Toastr.showError(errorMessage, context);
        });
        return null;
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
