import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/models/news/news_response.dart';
import 'package:sizer/sizer.dart';

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({super.key, required this.newsResponseModel});
  final NewsResponseModel newsResponseModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      appBar: const AppBarBackButton(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            SizedBox(
              height: 80.w,
              width: double.infinity,
              child: Stack(
                children: [
                  AppNetworkImage.appBase64Image(base64Image: newsResponseModel.image, height: 80, width: 100),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0, 0.4, 0.8, 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50.w,
              left: 5.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(newsResponseModel.title ?? "", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
                  Row(
                    children: [
                      IconManager.instance.customIcon(Icons.calendar_month_outlined, color: ColorManager.WHITE),
                      context.sized.emptySizedWidthBoxLow,
                      Text(AppConstant.dateFormat(context, newsResponseModel.date), style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: context.padding.horizontalLow,
              child: Container(
                margin: EdgeInsets.only(top: 70.w),
                padding: context.padding.horizontalLow,
                decoration: BoxDecoration(
                  color: ColorManager.WHITE,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.BLACK.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Html(data: newsResponseModel.content),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
