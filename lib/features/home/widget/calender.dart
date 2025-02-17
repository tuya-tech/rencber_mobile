import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/button/right_icon_button.dart';
import 'package:rencber_mobile/core/widget/calendar/calendar.dart';
import 'package:rencber_mobile/features/calendar/view/calendar.dart';
import 'package:rencber_mobile/product/models/field/field_islem_response.dart';
import 'package:sizer/sizer.dart';

class HomeCalendar extends StatelessWidget {
  const HomeCalendar({super.key, required this.fieldIslemData});
  final List<FieldIslemResponseModel> fieldIslemData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Takvim", style: context.general.textTheme.titleSmall),
            AppRightIconButton(onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context, screen:  CalendarView(fieldIslemData: fieldIslemData));
            }),
          ],
        ),
        SizedBox(
          height: 45.w,
          child: Card(
            color: ColorManager.WHITE,
            child: Padding(
              padding: context.padding.onlyLeftLow + context.padding.onlyRightLow + context.padding.onlyTopLow,
              child: AppCalendar(fieldIslemData: fieldIslemData),
            ),
          ),
        ),
      ],
    );
  }
}
