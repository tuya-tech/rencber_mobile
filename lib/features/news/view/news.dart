import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/card/blur_card.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/features/news/mixin/news_mixin.dart';
import 'package:rencber_mobile/product/provider/news/news_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class NewsView extends ConsumerStatefulWidget {
  const NewsView({super.key});

  @override
  ConsumerState<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends ConsumerState<NewsView> with NewsMixin {
  @override
  Widget build(BuildContext context) {
    var newsProvider = ref.watch(newsFutureProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.BGCOLOR,
      body: newsProvider.when(data: (newsData) {
        var (outLineData, normalData) = outLineAndNormalData(newsData.data!);
        return SliverAppBarCustom(
          height: 55,
          title: Text("Haberler", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
          appbarChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: context.padding.onlyLeftNormal, child: Text("Öne Çıkanlar", style: context.general.textTheme.titleSmall?.copyWith(color: ColorManager.WHITE))),
              SizedBox(
                height: 40.w,
                width: 100.w,
                child: ListView.builder(
                  //physics: const NeverScrollableScrollPhysics(),
                  padding: context.padding.onlyLeftNormal + context.padding.onlyBottomLow,
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
                            AppNetworkImage.appBase64Image(base64Image: outLineData[index].image, height: 30, width: 30),
                            context.sized.emptySizedWidthBoxLow3x,
                            Expanded(
                              child: Padding(
                                padding: context.padding.verticalLow,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(outLineData[index].title ?? "", maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.titleSmall?.copyWith(color: ColorManager.WHITE)),
                                    Text(outLineData[index].summary ?? "", maxLines: 3, overflow: TextOverflow.ellipsis, style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.WHITE.withOpacity(0.7))),
                                    Row(
                                      children: [
                                        IconManager.instance.customIcon(Icons.calendar_month_outlined, color: ColorManager.BUTTONBGGREEN),
                                        context.sized.emptySizedWidthBoxLow,
                                        Text(AppConstant.dateFormat(context, outLineData[index].date), style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
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
                    outLineData.length > 4 ? 4 : outLineData.length,
                    (index) {
                      int modIndex = currentIndex % (outLineData.length > 4 ? 4 : outLineData.length);
                      return Container(
                        width: modIndex == index ? 2.w : 1.5.w,
                        height: 2.3.w,
                        margin: EdgeInsets.symmetric(vertical: 1.w, horizontal: 1.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: modIndex == index ? ColorManager.WHITE : ColorManager.GREYCOLOR),
                          color: modIndex == index ? ColorManager.WHITE : ColorManager.WHITE,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
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
                        color: ColorManager.WHITE,
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 1.w, top: 2.w, bottom: 2.w),
                          child: Row(
                            children: [
                              AppNetworkImage.appBase64Image(base64Image: normalData[index].image, height: 30, width: 30),
                              context.sized.emptySizedWidthBoxLow3x,
                              Expanded(
                                child: Padding(
                                  padding: context.padding.verticalLow,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(normalData[index].title ?? "", maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.titleSmall),
                                      Text(normalData[index].summary ?? "", maxLines: 3, overflow: TextOverflow.ellipsis, style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.BLACK.withOpacity(0.7))),
                                      context.sized.emptySizedHeightBoxLow,
                                      Row(
                                        children: [
                                          IconManager.instance.customIcon(Icons.calendar_month_outlined, color: ColorManager.BUTTONBGGREEN),
                                          context.sized.emptySizedWidthBoxLow,
                                          Text(AppConstant.dateFormat(context, normalData[index].date), style: context.general.textTheme.bodySmall?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
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
        return DioErrorManager.dioError(error);
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
