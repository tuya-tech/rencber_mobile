import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/calendar/calendar.dart';
import 'package:rencber_mobile/core/widget/card/blur_card.dart';
import 'package:rencber_mobile/core/widget/icon/appbar_icon.dart';
import 'package:rencber_mobile/product/provider/home/home_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var homeProvider = ref.watch(homeFutureProvider);
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: homeProvider.when(data: (homeData) {
        var weatherData = homeData['weather']!.data;
        return SliverAppBarCustom(
          height: 55,
          title: SizedBox(width: 40.w, child: ImageManager.instance.logo),
          leading: Transform.translate(offset: const Offset(10, 0), child: AppbarIcon(child: IconManager.instance.customIcon(Icons.calendar_today_outlined, color: ColorManager.WHITE, sizeW: 5))),
          actions: [Transform.translate(offset: const Offset(-10, 0), child: AppbarIcon(child: IconManager.instance.customIcon(Icons.notifications_none_outlined, color: ColorManager.WHITE, sizeW: 5)))],
          appbarChild: Padding(
            padding: context.padding.onlyBottomLow + context.padding.onlyTopLow,
            child: BlurCard(
              height: 45,
              width: 93,
              child: Padding(
                padding: context.padding.low,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconManager.instance.customIcon(Icons.near_me, color: ColorManager.BUTTONBGGREEN, sizeW: 5),
                            context.sized.emptySizedWidthBoxLow,
                            Text("${weatherData?.city?.name ?? ""}, ${weatherData?.district?.name ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(color: ColorManager.WHITE)),
                          ],
                        ),
                        Text(AppConstant.dateFormat(context, weatherData?.date), style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                      ],
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    Padding(
                      padding: context.padding.horizontalNormal,
                      child: Row(
                        children: [
                          ImageManager.weatherImage(weatherData?.weatherType ?? ""),
                          context.sized.emptySizedWidthBoxLow3x,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${weatherData?.temperature ?? ""}°C", style: context.general.textTheme.headlineLarge?.copyWith(color: ColorManager.WHITE)),
                              context.sized.emptySizedHeightBoxLow,
                              Text(weatherData?.weatherType ?? "", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                            ],
                          ),
                          context.sized.emptySizedWidthBoxLow3x,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("En yüksek: ${weatherData?.maxTemperature ?? ""}°C", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                              context.sized.emptySizedHeightBoxLow,
                              Text("En düşük: ${weatherData?.minTemperature ?? ""}°C", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                            ],
                          )
                        ],
                      ),
                    ),
                    context.sized.emptySizedHeightBoxLow3x,
                    Padding(
                      padding: context.padding.horizontalLow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageManager.instance.rainFall,
                              context.sized.emptySizedWidthBoxLow3x,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Yağış Miktarı", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                                  Text("${weatherData?.rainFall ?? ""} mm", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageManager.instance.windFall,
                              context.sized.emptySizedWidthBoxLow3x,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rüzgar", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                                  Text("${weatherData?.windSpeed ?? ""} km/h", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageManager.instance.humanityFall,
                              context.sized.emptySizedWidthBoxLow3x,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nem Oranı", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                                  Text("%${weatherData?.humidity ?? ""}", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          child: Padding(
            padding: context.padding.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Takvim", style: context.general.textTheme.titleSmall),
                        //IconButton(onPressed: (){}, icon: IconManager.instance.customIcon(Icons.add, color: ColorManager.WHITE, sizeW: 5))
                      ],
                    ),
                    SizedBox(
                      height: 45.w,
                      child: Card(
                        color: ColorManager.WHITE,
                        child: Padding(
                          padding: context.padding.onlyLeftLow + context.padding.onlyRightLow + context.padding.onlyTopLow,
                          child: const AppCalendar(),
                        ),
                      ),
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tarlalarım", style: context.general.textTheme.titleSmall),
                        //IconButton(onPressed: (){}, icon: IconManager.instance.customIcon(Icons.add, color: ColorManager.WHITE, sizeW: 5))
                      ],
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    SizedBox(
                      height: 30.w,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              color: ColorManager.WHITE,
                              child: Padding(
                                padding: context.padding.low,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ImageManager.instance.tarla,
                                    context.sized.emptySizedWidthBoxLow3x,
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Tarla ${index + 1}", style: context.general.textTheme.titleSmall),
                                        const Text("Buğday"),
                                        const Text("Gün 89"),
                                        const Text("Evre : Uzama"),
                                        Text("Muttalıp Köyü, Beypazarı, Ankara", style: context.general.textTheme.bodyLarge),
                                      ],
                                    ),
                                    IconManager.instance.customIcon(Icons.more_horiz, color: ColorManager.BLACK, sizeW: 5),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tavsiyeler", style: context.general.textTheme.titleSmall),
                        //IconButton(onPressed: (){}, icon: IconManager.instance.customIcon(Icons.add, color: ColorManager.WHITE, sizeW: 5))
                      ],
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    SizedBox(
                      height: 65.w,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
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
                                    children: [
                                      ImageManager.instance.tarla,
                                      context.sized.emptySizedHeightBoxLow,
                                      Text("10 x 25 Kg Agsan %21 Azot", style: context.general.textTheme.labelLarge),
                                      context.sized.emptySizedHeightBoxLow,
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          backgroundColor: ColorManager.BUTTONBGGREEN.withOpacity(0.1),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "İncele",
                                              style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.BUTTONBGGREEN),
                                            ),
                                            IconManager.instance.customIcon(
                                              Icons.arrow_forward_sharp,
                                              color: ColorManager.BUTTONBGGREEN,
                                              sizeW: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
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
