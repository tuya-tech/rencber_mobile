import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/provider/news/news_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class NewsDetailsView extends ConsumerWidget {
  const NewsDetailsView({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var newsByIdProvider = ref.watch(newsIdFutureProvider(id));
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      appBar: const AppBarBackButton(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: newsByIdProvider.when(data: (newsIdData) {
        var newsResponseModel = newsIdData.data!;
        return SafeArea(
          top: false,
          child: Stack(
            children: [
              SizedBox(
                height: 80.w,
                width: double.infinity,
                child: Stack(
                  children: [
                    AppNetworkImage.appNetworkImage(imageUrl: newsResponseModel.image, height: 80, width: 100),
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
                          stops: const [0, 0.4, 0.8, 1],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: (newsResponseModel.title?.length ?? 0) > 25 ? 45.w : 50.w,
                left: 5.w,
                width: 70.w,
                height: 40.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsResponseModel.title ?? "",
                      style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE),
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        IconManager.instance.customIcon(Icons.calendar_month_outlined, color: ColorManager.WHITE),
                        context.sized.emptySizedWidthBoxLow,
                        Text(AppConstant.dateFormat(context, newsResponseModel.date) ?? "", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: context.padding.horizontalLow,
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.only(top: 70.w),
                  padding: context.padding.horizontalLow,
                  decoration: BoxDecoration(
                    color: ColorManager.WHITE,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.BLACK.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Html(data: newsResponseModel.content ?? ""),
                ),
              ),
            ],
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
