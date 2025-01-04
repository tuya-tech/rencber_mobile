import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:sizer/sizer.dart';

class BrandListView extends ConsumerStatefulWidget {
  const BrandListView({super.key, required this.adviceList});
  final List<AdviceResponseModel> adviceList;

  @override
  ConsumerState<BrandListView> createState() => _BrandListViewState();
}

class _BrandListViewState extends ConsumerState<BrandListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 5,
        leading: const AppBarBackButton(),
        title: Text("Tavsiyeler", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        child: Padding(
          padding: context.padding.low,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Aydınlı Biyoteknoloji A.Ş", style: context.general.textTheme.titleSmall),
              context.sized.emptySizedHeightBoxLow,
              GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.adviceList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .7),
                itemBuilder: (context, index) {
                  var brands = widget.adviceList[index];
                  return SizedBox(
                    child: Card(
                      elevation: 0.5,
                      color: ColorManager.WHITE,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                AppNetworkImage.appNetworkImage(imageUrl: brands.image, height: 30, width: 100),
                                context.sized.emptySizedHeightBoxLow,
                                Text('${brands.title}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.titleMedium),
                                Text('${brands.summary}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.GREYCOLOR)),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxLow,
                            AppElevetedButton(
                              buttonText: "İncele",
                              buttonHeight: 10,
                              textStyle: context.general.textTheme.bodyLarge?.copyWith(color: ColorManager.WHITE, fontSize: 15.5.sp),
                              onPressed: () => context.push(RouterManager.brandDetails, extra: brands.id),
                            )
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
      ),
    );
  }
}
