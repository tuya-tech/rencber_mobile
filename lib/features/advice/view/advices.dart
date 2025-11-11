import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/review_button.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';

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
      backgroundColor: ColorManager.bgColor,
      body: SliverAppBarCustom(
        height: 5,
        leading: const AppBarBackButton(),
        title: Text(
          "Size Özel",
          style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white),
        ),
        child: Padding(
          padding: context.padding.low,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Size Özel Önerileri Keşfedin",
                style: context.general.textTheme.titleSmall,
              ),
              context.sized.emptySizedHeightBoxLow,
              GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.adviceList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 🔹 2 sütun
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final advice = widget.adviceList[index];

                  return Card(
                    elevation: 0.8,
                    color: ColorManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: AppNetworkImage.appNetworkImage(
                                  imageUrl: advice.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          context.sized.emptySizedHeightBoxLow,
                          Expanded(
                            flex: 3,
                            child: Text(
                              advice.title ?? "",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: context.general.textTheme.labelLarge?.copyWith(
                                color: ColorManager.greyColor,
                              ),
                            ),
                          ),
                          context.sized.emptySizedHeightBoxLow,
                          Expanded(
                            flex: 2,
                            child: AppReview(
                              onTap: () => context.push(
                                RouterManager.adviceDetails,
                                extra: advice.id,
                              ),
                            ),
                          ),
                        ],
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
