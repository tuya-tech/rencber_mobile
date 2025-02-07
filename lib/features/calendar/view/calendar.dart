import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/calendar/calendar.dart';
import 'package:rencber_mobile/features/fields/view/field_detail.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key});

  @override
  ConsumerState<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 15,
        leading: const AppBarBackButton(),
        title: Text("Takvim", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        child: Padding(
          padding: context.padding.low,
          child: Column(
            spacing: 4.w,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.WHITE,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const AppCalendar(
                  format: CalendarFormat.month,
                  headerVisible: true,
                  rowHeight: 12,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bu Ay", style: context.general.textTheme.titleSmall?.copyWith(color: ColorManager.BLACK)),
                  AppElevetedButton(
                    buttonwidth: 28,
                    buttonHeight: 10,
                    leftIconData: Icons.add,
                    buttonText: "Ekle",
                    textStyle: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.WHITE),
                    onPressed: () {},
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: context.padding.onlyTopLow,
                    child: const IslermlerCardWidget(color: ColorManager.BLUE),
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
