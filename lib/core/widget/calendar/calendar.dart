import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/product/models/field/field_islem_response.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key, this.format, this.headerVisible, this.rowHeight, this.fieldIslemData, this.isVisibleEventText = false});
  final CalendarFormat? format;
  final bool? headerVisible;
  final double? rowHeight;
  final List<FieldIslemResponseModel>? fieldIslemData;
  final bool isVisibleEventText;

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime _selectedDay = DateTime.now();
  Map<String, List> _events = {};

  Color markerColors(List selectedDay) {
    if (selectedDay.contains('SULAMA')) {
      return ColorManager.blue;
    } else if (selectedDay.contains('GUBRELEME')) {
      return ColorManager.brown;
    } else if (selectedDay.contains('CAPALAMA')) {
      return ColorManager.orange;
    }
    return ColorManager.white;
  }

  String selectedMarkerText(DateTime selectedDay) {
    var dateFormat = DateFormat('dd.MM.yyyy').format(selectedDay);
    var events = _events[dateFormat]?.toSet();
    if (events != null) {
      return events.join(', ');
    }
    return '';
  }

  void setEvent() {
    _events.clear();
    widget.fieldIslemData?.forEach((element) {
      var date = element.startDate;
      if (_events[date] == null) {
        _events[date!] = [];
      }
      if (!_events[date]!.contains(element.id)) {
        _events[date]!.add(element.islemTipi);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _events = {};
    setEvent();
  }

@override
  void didUpdateWidget(covariant AppCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.fieldIslemData != oldWidget.fieldIslemData) {
      _events = {};
      setEvent();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          rowHeight: widget.rowHeight?.w ?? 17.w,
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          calendarFormat: widget.format ?? CalendarFormat.week,
          headerVisible: widget.headerVisible ?? false,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: context.general.textTheme.labelMedium!.copyWith(color: ColorManager.black),
            leftChevronIcon: const Icon(Icons.chevron_left, color: ColorManager.black),
            rightChevronIcon: const Icon(Icons.chevron_right, color: ColorManager.black),
            titleTextFormatter: (date, locale) => DateFormat.MMMM(locale).format(date),
          ),
          daysOfWeekHeight: 6.w,
          locale: 'tr_TR',
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, events) {
              return Container(
                margin: EdgeInsets.only(top: 4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.blue,
                  shape: widget.isVisibleEventText ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: widget.isVisibleEventText ? null : BorderRadius.circular(10),
                ),
                child: Text(
                  date.day.toString(),
                  style: context.general.textTheme.labelMedium!.copyWith(color: ColorManager.white),
                ),
              );
            },
            markerBuilder: (context, date, events) {
              if (events.isEmpty) return null;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: markerColors(events),
                  shape: BoxShape.circle,
                ),
                width: 2.w,
                height: 2.w,
              );
            },
            outsideBuilder: (context, date, events) {
              return Container(
                margin: EdgeInsets.only(top: 4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  date.day.toString(),
                  style: context.general.textTheme.labelSmall!.copyWith(color: ColorManager.black..withValues(alpha: 0.2)),
                ),
              );
            },
            defaultBuilder: (context, date, events) {
              return Container(
                margin: EdgeInsets.only(top: 4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  date.day.toString(),
                  style: context.general.textTheme.labelSmall!.copyWith(color: ColorManager.black),
                ),
              );
            },
            dowBuilder: (context, day) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  DateFormat('EEE.', "tr_TR").format(day),
                  style: context.general.textTheme.titleMedium!.copyWith(color: ColorManager.black),
                ),
              );
            },
          ),
          eventLoader: (day) {
            return _events[DateFormat('dd.MM.yyyy').format(day)] ?? [];
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
        ),
        !widget.isVisibleEventText ? context.sized.emptySizedHeightBoxLow3x : const SizedBox.shrink(),
        !widget.isVisibleEventText
            ? Padding(
                padding: context.padding.onlyLeftNormal,
                child: Row(
                  spacing: 2.w,
                  children: [
                    if (selectedMarkerText(_selectedDay) == "SULAMA") SizedBox(width: 5.w, height: 5.w, child: ImageManager.instance.sulama),
                    if (selectedMarkerText(_selectedDay) == "GUBRELEME") SizedBox(width: 5.w, height: 5.w, child: ImageManager.instance.gubreleme),
                    if (selectedMarkerText(_selectedDay) == "CAPALAMA") SizedBox(width: 5.w, height: 5.w, child: ImageManager.instance.capalama),
                    selectedMarkerText(_selectedDay).ext.isNotNullOrNoEmpty
                        ? Text(
                            AppConstant.dateFormat(context, _selectedDay.toString()) == AppConstant.dateFormat(context, DateTime.now().toString()) ? "Bugün ${selectedMarkerText(_selectedDay).toLowerCase()} işlemi yapılacak" : "${selectedMarkerText(_selectedDay).ext.toCapitalized()} işlemi yapıldı",
                            style: context.general.textTheme.bodySmall!.copyWith(color: ColorManager.black),
                          )
                        : Text(
                            "Bugün için işlem bulunmamaktadır",
                            style: context.general.textTheme.bodySmall!.copyWith(color: ColorManager.black),
                          )
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
