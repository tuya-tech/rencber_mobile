import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/button/review_button.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:sizer/sizer.dart';

class AdvicesView extends ConsumerStatefulWidget {
  const AdvicesView({super.key, required this.adviceList});
  final List<AdviceResponseModel> adviceList;

  @override
  ConsumerState<AdvicesView> createState() => _AdvicesViewState();
}

class _AdvicesViewState extends ConsumerState<AdvicesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 5,
        leading: const AppBarBackButton(),
        title: Text("Size Özel", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        child: Padding(
          padding: context.padding.low,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Size Özel Önerileri Keşfedin", style: context.general.textTheme.titleSmall),
              context.sized.emptySizedHeightBoxLow,
              GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.adviceList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: .65),
                itemBuilder: (context, index) {
                  var advice = widget.adviceList[index];
                  return SizedBox(
                    child: Card(
                      elevation: 0.5,
                      color: ColorManager.WHITE,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                AppNetworkImage.appNetworkImage(imageUrl: advice.image, height: 25, width: 100),
                                context.sized.emptySizedHeightBoxLow,
                                Text('${advice.title}', maxLines: 2, overflow: TextOverflow.ellipsis, style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.GREYCOLOR)),
                              ],
                            ),
                            context.sized.emptySizedHeightBoxLow,
                            AppReview(
                              onTap: () => context.push(RouterManager.adviceDetails, extra: advice.id),
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
