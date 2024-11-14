import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/card/blur_card.dart';
import 'package:rencber_mobile/features/news/mixin/news_mixin.dart';
import 'package:sizer/sizer.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> with NewsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 55,
        title: Text("Haberler", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        appbarChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: context.padding.onlyLeftNormal, child: Text("Öne Çıkanlar", style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.WHITE))),
            SizedBox(
              height: 45.w,
              width: 100.w,
              child: ListView.builder(
                padding: context.padding.onlyLeftNormal + context.padding.onlyBottomNormal,
                scrollDirection: Axis.horizontal,
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return BlurCard(
                    height: 45,
                    width: 70,
                    child: ListTile(title: Text("Haber $index")),
                  );
                },
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.sized.emptySizedHeightBoxLow3x,
            Padding(padding: context.padding.onlyLeftNormal, child: Text("Gündem", style: context.general.textTheme.titleSmall)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: context.padding.onlyLeftNormal + context.padding.onlyBottomNormal + context.padding.onlyRightNormal,
              itemCount: newsList2.length,
              itemBuilder: (context, index) {
                return Card(
                  color: ColorManager.WHITE,
                  child: ListTile(
                    title: Text(newsList2[index]["title"]),
                    subtitle: Text(newsList2[index]["content"]),
                    //leading: Image.network(newsList[index]["image"]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
