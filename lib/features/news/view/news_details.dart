import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/provider/news/news_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class NewsDetailsView extends ConsumerWidget {
  const NewsDetailsView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsIdFutureProvider(id));

    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: newsAsync.when(
        data: (data) {
          final news = data.data!;

          return SliverAppBarCustom(
            height: 2,
            leading: const AppBarBackButton(),
            title: Text(
              "Haber Detayı",
              style: context.general.textTheme.headlineMedium
                  ?.copyWith(color: ColorManager.white),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        AppNetworkImage.appNetworkImage(
                          imageUrl: news.image,
                          height: 16.w,
                          width: 100,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.7),
                                Colors.black.withValues(alpha: 0.4),
                                Colors.black.withValues(alpha: 0.4),
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                news.title ?? "",
                                style: context.general.textTheme.headlineMedium
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              context.sized.emptySizedHeightBoxLow,
                              Row(
                                children: [
                                  IconManager.instance.customIcon(
                                    Icons.calendar_month_outlined,
                                    color: ColorManager.white,
                                    // sizeW: 16.sp,
                                  ),
                                  context.sized.emptySizedWidthBoxLow,
                                  Text(
                                    AppConstant.dateFormat(
                                          context,
                                          news.date,
                                        ) ??
                                        "",
                                    style: context.general.textTheme.labelLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  context.sized.emptySizedHeightBoxLow3x,

                  // İçerik alanı
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Html(
                      data: news.content ?? "",
                      style: {
                        "body": Style(
                          fontSize: FontSize(14.sp),
                          color: Colors.black87,
                          lineHeight: const LineHeight(1.5),
                          padding: HtmlPaddings.zero,
                          margin: Margins.zero,
                        ),
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
          return DioErrorManager.dioError(error);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
