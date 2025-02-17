import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/button/review_button.dart';
import 'package:rencber_mobile/core/widget/button/right_icon_button.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:rencber_mobile/product/provider/navbar/navbar_provider.dart';
import 'package:sizer/sizer.dart';

class HomeAdviceList extends ConsumerWidget {
  const HomeAdviceList({super.key, required this.adviceData});
  final List<AdviceResponseModel> adviceData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tavsiyeler", style: context.general.textTheme.titleSmall),
            AppRightIconButton(onPressed: () => ref.read(navbarSelectedProvider.notifier).notify(1))
            //IconButton(onPressed: (){}, icon: IconManager.instance.customIcon(Icons.add, color: ColorManager.WHITE, sizeW: 5))
          ],
        ),
        context.sized.emptySizedHeightBoxLow,
        SizedBox(
          height: 65.w,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: adviceData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 40.w,
                child: Card(
                  color: ColorManager.WHITE,
                  child: Padding(
                    padding: context.padding.low,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppNetworkImage.appNetworkImage(imageUrl: adviceData[index].image, height: 30, width: 30),
                        context.sized.emptySizedHeightBoxLow,
                        Text(adviceData[index].title ?? "", style: context.general.textTheme.labelLarge),
                        context.sized.emptySizedHeightBoxLow,
                        AppReview(
                          onTap: () {
                            context.push(RouterManager.adviceDetails, extra: adviceData[index].id);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
