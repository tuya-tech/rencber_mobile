import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/card/blur_card.dart';
import 'package:rencber_mobile/core/widget/icon/appbar_icon.dart';
import 'package:rencber_mobile/features/home/widget/advice.dart';
import 'package:rencber_mobile/features/home/widget/calender.dart';
import 'package:rencber_mobile/features/home/widget/fields.dart';
import 'package:rencber_mobile/features/notification/view/notification_view.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:rencber_mobile/product/models/field/field_islem_response.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/models/weather/weather_response.dart';
import 'package:rencber_mobile/product/provider/home/home_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool _hasShownDialog = false;
  bool isField = false; //TODO unutma burayı

  void _showNoFieldDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 37.h,
            width: 80.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorManager.BGCOLOR),
            child: Padding(
              padding: context.padding.normal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 4.h,
                children: [
                  IconManager.instance.customIcon(Icons.warning_amber_rounded, color: ColorManager.BUTTONREDCOLOR, sizeW: 20),
                  Text("Henüz tarlanız bulunmamaktadır. İşlemlerinize devem etmek istiyorsanız tarla eklemelisiniz.", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.BLACK), textAlign: TextAlign.center),
                  AppElevetedButton(
                    buttonText: "Tarla Ekle",
                    onPressed: () {
                      context.push(RouterManager.addField);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    setState(() {
      _hasShownDialog = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = ref.watch(homeFutureProvider);
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: homeProvider.when(data: (homeData) {
        if (homeData['field'] == null && !_hasShownDialog) {
          setState(() {
            isField = false;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showNoFieldDialog();
          });
        } else {
          setState(() {
            isField = true;
          });
        }

        var weatherData = homeData['weather'] != null ? homeData['weather'] as WeatherResponseModel : WeatherResponseModel();
        var adviceData = homeData['advice'] != null ? homeData['advice'] as List<AdviceResponseModel> : List<AdviceResponseModel>.empty();
        var fieldData = homeData['field'] != null ? homeData['field'] as List<FieldResponseModel> : List<FieldResponseModel>.empty();
        var fieldIslemData = homeData['fieldIslem'] != null ? homeData['fieldIslem'] as List<FieldIslemResponseModel> : List<FieldIslemResponseModel>.empty();
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
          appbarChild: isField
              ? Padding(
                  padding: context.padding.onlyBottomLow + context.padding.onlyTopLow,
                  child: BlurCard(
                    height: 45,
                    width: 93,
                    child: Padding(
                      padding: context.padding.low,
                      child: InkWell(
                          onTap: () {
                            context.push(RouterManager.weather);
                          },
                          child: HomeWeather(weatherData: weatherData)),
                    ),
                  ),
                )
              : null,
          child: isField
              ? Padding(
                  padding: context.padding.low,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeCalendar(fieldIslemData: fieldIslemData),
                          context.sized.emptySizedHeightBoxLow,
                          HomeFieldList(fieldData: fieldData),
                          context.sized.emptySizedHeightBoxLow,
                          HomeAdviceList(adviceData: adviceData),
                        ],
                      ),
                    ],
                  ),
                )
              : null,
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

class HomeWeather extends StatefulWidget {
  const HomeWeather({super.key, required this.weatherData});

  final WeatherResponseModel? weatherData;

  @override
  State<HomeWeather> createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  String weatherTypeLanguage(String? weatherType) {
    switch (weatherType) {
      case "Clear":
        return "Açık";
      case "Clouds":
        return "Bulutlu";
      case "Rain":
        return "Yağmurlu";
      case "Snow":
        return "Karlı";
      case "Mist":
        return "Sisli";
      case "Fog":
        return "Sisli";
      case "Haze":
        return "Sisli";
      case "Dust":
        return "Tozlu";
      case "Sand":
        return "Kum Fırtınalı";
      case "Ash":
        return "Kül Fırtınalı";
      case "Squall":
        return "Fırtınalı";
      case "Tornado":
        return "Tornado";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.weatherData?.id != null
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
                      Text("${widget.weatherData?.city?.name ?? ""}, ${widget.weatherData?.district?.name ?? ""}", style: context.general.textTheme.bodyMedium?.copyWith(color: ColorManager.WHITE)),
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
                    ImageManager.weatherImage(widget.weatherData?.weatherIcon ?? ""),
                    context.sized.emptySizedWidthBoxLow3x,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.weatherData?.tempDay ?? ""}°C", style: context.general.textTheme.headlineLarge?.copyWith(color: ColorManager.WHITE)),
                        context.sized.emptySizedHeightBoxLow,
                        Text(weatherTypeLanguage(widget.weatherData?.weatherMain?.ext.toCapitalized()), style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                      ],
                    ),
                    context.sized.emptySizedWidthBoxLow3x,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("En yüksek: ${widget.weatherData?.tempMax ?? ""}°C", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
                        context.sized.emptySizedHeightBoxLow,
                        Text("En düşük: ${widget.weatherData?.tempMin ?? ""}°C", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)),
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
                            Text("${widget.weatherData?.rain ?? ""} mm", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
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
                            Text("${widget.weatherData?.windSpeed ?? ""} km/h", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
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
                            Text("%${widget.weatherData?.humidity ?? ""}", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        : Center(child: Text("Hava Durumu Bulunamadı", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.WHITE)));
  }
}
