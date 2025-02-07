import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/card/blur_card.dart';
import 'package:rencber_mobile/core/widget/icon/appbar_icon.dart';
import 'package:rencber_mobile/features/home/widget/advice.dart';
import 'package:rencber_mobile/features/home/widget/calender.dart';
import 'package:rencber_mobile/features/home/widget/fields.dart';
import 'package:rencber_mobile/features/notification/view/notification_view.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/models/weather/weather_response.dart';
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
        var weatherData = homeData['weather'] != null ? homeData['weather'] as WeatherResponseModel : WeatherResponseModel();
        var adviceData = homeData['advice'] as List<AdviceResponseModel>;
        var fieldData = homeData['field'] != null ? homeData['field'] as List<FieldResponseModel> : List<FieldResponseModel>.empty();
        fieldData.sort((a, b) => a.outline == true ? -1 : 1);
        return SliverAppBarCustom(
          height: 55,
          title: SizedBox(width: 40.w, child: ImageManager.instance.logo),
          //leading: Transform.translate(offset: const Offset(10, 0), child: AppbarIcon(child: IconManager.instance.customIcon(Icons.calendar_today_outlined, color: ColorManager.WHITE, sizeW: 5))),
          actions: [
            Transform.translate(
              offset: const Offset(-10, 0),
              child: AppbarIcon(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(context, screen: const NotificationView());
                },
                child: IconManager.instance.customIcon(Icons.notifications_none_outlined, color: ColorManager.WHITE, sizeW: 5),
              ),
            ),
          ],
          appbarChild: Padding(
            padding: context.padding.onlyBottomLow + context.padding.onlyTopLow,
            child: BlurCard(
              height: 45,
              width: 93,
              child: Padding(
                padding: context.padding.low,
                child: HomeWeather(weatherData: weatherData),
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
                    const HomeCalendar(),
                    context.sized.emptySizedHeightBoxLow,
                    HomeFieldList(fieldData: fieldData),
                    context.sized.emptySizedHeightBoxLow,
                    HomeAdviceList(adviceData: adviceData),
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

class HomeWeather extends StatelessWidget {
  const HomeWeather({super.key, required this.weatherData});

  final WeatherResponseModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return weatherData?.id != null
        ? Column(
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
                  //Text(AppConstant.dateFormat(context, weatherData?.date), style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
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
          )
        : const SizedBox.shrink();
  }
}
