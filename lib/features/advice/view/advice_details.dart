import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/image/network_image.dart';
import 'package:rencber_mobile/product/provider/advice/advice_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AdviceDetailsView extends ConsumerStatefulWidget {
  const AdviceDetailsView({super.key, required this.adviceId});
  final int adviceId;

  @override
  ConsumerState<AdviceDetailsView> createState() => _AdviceDetailsViewState();
}

class _AdviceDetailsViewState extends ConsumerState<AdviceDetailsView> {
  @override
  Widget build(BuildContext context) {
    var brandProvider = ref.watch(adviceIdFutureProvider(widget.adviceId));
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: brandProvider.when(
        data: (brandData) {
          var advice = brandData.data!;
          return SliverAppBarCustom(
            height: 5,
            leading: const AppBarBackButton(),
            title: Text("Ürün Detayı", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
            child: Container(
              margin: context.padding.normal,
              decoration: BoxDecoration(
                color: ColorManager.CONTAINERGREY,
                borderRadius: BorderRadius.circular(39),
              ),
              child: Column(
                children: [
                  AppNetworkImage.appNetworkImage(imageUrl: advice.image ?? "", height: 65, width: 100),
                  context.sized.emptySizedHeightBoxLow,
                  Text(advice.title ?? "", style: context.general.textTheme.headlineMedium),
                  Container(
                    height: 70.w,
                    decoration: BoxDecoration(
                      color: ColorManager.WHITE,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Html(data: advice.content ?? ""),
                  ),
                  context.sized.emptySizedHeightBoxLow,
                  AppElevetedButton(
                    buttonText: "Web Sitesini Ziyaret Et",
                    rightIconData: Icons.arrow_outward_rounded,
                    onPressed: () async {
                      await launchUrl(Uri(scheme: "https", path: advice.webSite ?? ""));
                    },
                  ),
                  context.sized.emptySizedHeightBoxLow,
                  AppElevetedButton(
                    buttonText: "Haritaları Aç",
                    buttonColor: ColorManager.BGCOLOR,
                    borderColor: ColorManager.GREEN,
                    textColor: ColorManager.GREEN,
                    rightIconData: Icons.arrow_outward_rounded,
                    onPressed: () async {
                      await launchUrl(Uri(scheme: "https", path: "www.google.com/maps/search/?api=1&query=${advice.latitude},${advice.longitude}"));
                    },
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
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
