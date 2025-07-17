import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/controller/exception.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/product/provider/weather/weather_provider.dart';
import 'package:sizer/sizer.dart';

class WeatherView extends ConsumerStatefulWidget {
  const WeatherView({super.key});

  @override
  ConsumerState<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends ConsumerState<WeatherView> {
  // Helper method to get day name from date
  String getDayName(String dateString) {
    try {
      // Parse date in format "dd.MM.yyyy"
      List<String> parts = dateString.split('.');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);

        // Create DateTime object
        DateTime date = DateTime(year, month, day);

        List<String> weekdays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
        return weekdays[date.weekday - 1];
      }
      return dateString; // Return original if not in expected format
    } catch (e) {
      return dateString; // Return original string if parsing fails
    }
  }

  // Helper method to format date as day/month
  String formatDayMonth(String dateString) {
    try {
      List<String> parts = dateString.split('.');
      if (parts.length == 3) {
        return "${parts[0]}/${parts[1]}"; // Return day/month format
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }

  // Calculate daylight duration from sunrise and sunset times
  String calculateDaylightDuration(String sunrise, String sunset) {
    try {
      // Parse datetime strings (format: "dd.MM.yyyy HH:mm")
      DateTime sunriseTime = _parseDateTime(sunrise);
      DateTime sunsetTime = _parseDateTime(sunset);

      // Calculate the difference
      Duration difference = sunsetTime.difference(sunriseTime);

      // Get total hours as double to handle partial hours
      double totalHours = difference.inMinutes / 60.0;

      // Round to nearest whole hour
      int roundedHours = totalHours.round();

      // Return only hours
      return "${roundedHours}h";
    } catch (e) {
      return "Hesaplanamadı";
    }
  }

  DateTime _parseDateTime(String dateTimeStr) {
    // Split by space to separate date and time
    List<String> parts = dateTimeStr.split(' ');
    if (parts.length != 2) {
      throw const FormatException("Invalid datetime format");
    }

    String dateStr = parts[0];
    String timeStr = parts[1];

    // Parse date (dd.MM.yyyy)
    List<String> dateParts = dateStr.split('.');
    if (dateParts.length != 3) {
      throw const FormatException("Invalid date format");
    }
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    // Parse time (HH:mm)
    List<String> timeParts = timeStr.split(':');
    if (timeParts.length != 2) {
      throw const FormatException("Invalid time format");
    }
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Create DateTime object
    return DateTime(year, month, day, hour, minute);
  }

  // Helper method to extract just the time portion from datetime string
  String getTimeOnly(String dateTimeStr) {
    try {
      // Split the string by space and get the second part (the time)
      List<String> parts = dateTimeStr.split(' ');
      if (parts.length == 2) {
        return parts[1]; // Return just the time portion (HH:mm)
      }
      return dateTimeStr; // Return original if not in expected format
    } catch (e) {
      return dateTimeStr; // Return original string if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    var weatherFuture = ref.watch(weatherFutureProvider);
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: weatherFuture.when(
        data: (weatherData) {
          var weather = weatherData.data ?? [];
          var todayWeather = weatherData.data?.first;
          if (weather.isEmpty) {
            return const Center(child: Text("Hava durumu verisi bulunamadı"));
          }
          return SliverAppBarCustom(
            leading: const AppBarBackButton(),
            height: 60,
            title: Text("Hava Durumu", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
            appbarChild: Padding(
              padding: context.padding.onlyBottomNormal,
              child: Column(
                spacing: 1.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2.w,
                    children: [
                      Text(todayWeather!.date.toString(), style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                      Text(getDayName(todayWeather.date.toString()), style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                    ],
                  ),
                  Text(todayWeather.city!.name.toString(), style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
                  Text("${todayWeather.tempDay?.round().toString()}°", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
                  Text(todayWeather.weatherDescription.ext.toCapitalized(), style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 2.w,
                    children: [
                      Text("Y: ${todayWeather.tempMax?.round().toString()}°", style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                      Text("D: ${todayWeather.tempMin?.round().toString()}°", style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.w,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 2.w,
                            children: [
                              IconManager.instance.customIcon(Icons.wb_sunny_outlined, sizeW: 5, color: ColorManager.white),
                              IconManager.instance.customIcon(Icons.arrow_upward_outlined, sizeW: 5, color: ColorManager.white),
                              Text(getTimeOnly(todayWeather.sunrise.toString()), style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 2.w,
                            children: [
                              IconManager.instance.customIcon(Icons.wb_sunny_outlined, sizeW: 5, color: ColorManager.white),
                              IconManager.instance.customIcon(Icons.arrow_downward_outlined, sizeW: 5, color: ColorManager.white),
                              Text(getTimeOnly(todayWeather.sunset.toString()), style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 2.w,
                            children: [
                              IconManager.instance.customIcon(Icons.download_sharp, sizeW: 5, color: ColorManager.white),
                              Text("${todayWeather.pressure?.round().toString()} hpa", style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 2.w,
                            children: [
                              IconManager.instance.customIcon(Icons.water_drop_outlined, sizeW: 5, color: ColorManager.white),
                              Text("${todayWeather.rain?.round().toString()}%", style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.white)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            child: Padding(
              padding: context.padding.verticalLow + context.padding.horizontalNormal,
              child: Column(
                spacing: 2.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${weather.length} Günlük Hava Durumu", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.black)),
                  SizedBox(
                      height: 130.h,
                      child: weather.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: context.padding.onlyBottomHigh * 5,
                              itemCount: weather.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 15.w,
                                  decoration: const BoxDecoration(
                                    color: ColorManager.white,
                                    border: Border(
                                      top: BorderSide(color: ColorManager.borderGray, width: 0.5),
                                      bottom: BorderSide(color: ColorManager.borderGray, width: 0.5),
                                    ),
                                    //borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: context.padding.horizontalLow,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(getDayName(weather[index].date.toString()), style: context.general.textTheme.labelLarge),
                                            const SizedBox(height: 5),
                                            Text(formatDayMonth(weather[index].date.toString()), style: context.general.textTheme.labelLarge),
                                          ],
                                        ),
                                        SizedBox(width: 5.w),
                                        SizedBox(width: 5.w, child: ImageManager.weatherImage(weather[index].weatherIcon.toString())),
                                        SizedBox(width: 2.w),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconManager.instance.customIcon(Icons.arrow_downward_outlined, sizeW: 5, color: ColorManager.greyColor),
                                            const SizedBox(height: 5),
                                            Text("${weather[index].tempMax?.round().toString()}°", style: context.general.textTheme.labelLarge),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconManager.instance.customIcon(Icons.arrow_upward_outlined, sizeW: 5, color: ColorManager.textGreyColor),
                                            const SizedBox(height: 5),
                                            Text("${weather[index].tempMin?.round().toString()}°", style: context.general.textTheme.labelLarge),
                                          ],
                                        ),
                                        SizedBox(width: 3.w),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ImageManager.instance.miniRain,
                                            const SizedBox(height: 5),
                                            Text("${weather[index].rain?.round().toString()}%", style: context.general.textTheme.labelLarge),
                                          ],
                                        ),
                                        SizedBox(width: 3.w),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ImageManager.instance.miniSun,
                                            const SizedBox(height: 5),
                                            Text(calculateDaylightDuration(weather[index].sunrise.toString(), weather[index].sunset.toString()), style: context.general.textTheme.labelLarge),
                                          ],
                                        ),
                                        SizedBox(width: 3.w),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ImageManager.instance.miniWind,
                                            const SizedBox(height: 5),
                                            Text("${weather[index].windSpeed?.round().toString()} km/s", style: context.general.textTheme.labelLarge),
                                          ],
                                        ),
                                        SizedBox(width: 2.w),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text("Bildirim Bulunamadı", style: TextStyle(color: ColorManager.black)))),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          debugPrint("Error: $error");

          // Hata mesajını toast olarak göster
          WidgetsBinding.instance.addPostFrameCallback((_) {
            String errorMessage = "Hava durumu verileri yüklenirken hata oluştu";

            // Eğer hata string ise ve backend hata kodu içeriyorsa işle
            if (error is String) {
              errorMessage = ExceptionHandler.handleException(error);
            }

            Toastr.showError(errorMessage, context);
          });
          return null;
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
      // body: SliverAppBarCustom(
      //   leading: const AppBarBackButton(),
      //   height: 5,
      //   title: Text("Bildirimlerim", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
      //   child: Padding(
      //     padding: context.padding.verticalLow + context.padding.horizontalNormal,
      //     child: SizedBox(
      //       height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - context.padding.verticalLow.vertical,
      //       child: ListView.builder(
      //         padding: context.padding.onlyBottomHigh * 3,
      //         itemCount: 9,
      //         itemBuilder: (context, index) {
      //           return Container(
      //             height: 25.w,
      //             decoration: const BoxDecoration(
      //               color: ColorManager.white,
      //               border: Border(
      //                 top: BorderSide(color: ColorManager.borderGray, width: 0.5),
      //                 bottom: BorderSide(color: ColorManager.borderGray, width: 0.5),
      //               ),
      //               //borderRadius: BorderRadius.circular(10),
      //             ),
      //             child: ListTile(
      //               splashColor: ColorManager.white,
      //               tileColor: ColorManager.white,
      //               onTap: () {},
      //               title: Text("Bildirim Başlığı", style: context.general.textTheme.titleMedium),
      //               subtitle: Text("Bildirim Açıklaması", style: context.general.textTheme.bodyLarge),
      //               trailing: Text("12:00", style: context.general.textTheme.bodyLarge),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
