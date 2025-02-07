import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key, this.format, this.headerVisible, this.rowHeight});
  final CalendarFormat? format;
  final bool? headerVisible;
  final double? rowHeight;

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime _selectedDay = DateTime.now();
  final Map<String, List> _events = {
    "2025-02-24": ['Event A0'],
    "2025-02-23": ['Event A1'],
    "2025-02-22": ['Event A2'],
  };

  Color markerColors(DateTime selectedDay) {
    return ColorManager.GREEN;
  }

  String selectedMarkerText(DateTime selectedDay) {
    var dateFormat = DateFormat('yyyy-MM-dd').format(selectedDay);
    var events = _events[dateFormat];
    if (events != null) {
      return events.join('\n');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            titleTextStyle: context.general.textTheme.labelMedium!.copyWith(color: ColorManager.BLACK),
            leftChevronIcon: const Icon(Icons.chevron_left, color: ColorManager.BLACK),
            rightChevronIcon: const Icon(Icons.chevron_right, color: ColorManager.BLACK),
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
                  color: ColorManager.BLUE,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  date.day.toString(),
                  style: context.general.textTheme.labelMedium!.copyWith(color: ColorManager.WHITE),
                ),
              );
            },
            markerBuilder: (context, date, events) {
              if (events.isEmpty) return null;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: markerColors(_selectedDay),
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
                  color: ColorManager.WHITE,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  date.day.toString(),
                  style: context.general.textTheme.labelSmall!.copyWith(color: ColorManager.BLACK..withValues(alpha: 0.2)),
                ),
              );
            },
            defaultBuilder: (context, date, events) {
              return Container(
                margin: EdgeInsets.only(top: 4.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.WHITE,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  date.day.toString(),
                  style: context.general.textTheme.labelSmall!.copyWith(color: ColorManager.BLACK),
                ),
              );
            },
            dowBuilder: (context, day) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  DateFormat('EEE.').format(day),
                  style: context.general.textTheme.titleMedium!.copyWith(color: ColorManager.BLACK),
                ),
              );
            },
          ),
          eventLoader: (day) {
            return _events[DateFormat('yyyy-MM-dd').format(day)] ?? [];
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
        ),
        context.sized.emptySizedHeightBoxLow3x,
        Text(selectedMarkerText(_selectedDay)),
      ],
    );
  }
}
