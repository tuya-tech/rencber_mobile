import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/calendar/calendar.dart';
import 'package:rencber_mobile/features/fields/view/field_detail.dart';
import 'package:rencber_mobile/product/models/field/field_islem_response.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key, this.fieldIslemData});
  final List<FieldIslemResponseModel>? fieldIslemData;

  @override
  ConsumerState<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {
  int fieldId = 0;

  Color markerColors(String selectedDay) {
    if (selectedDay == 'SULAMA') {
      return ColorManager.BLUE;
    } else if (selectedDay == 'GUBRELEME') {
      return ColorManager.BROWN;
    } else if (selectedDay == 'CAPALAMA') {
      return ColorManager.ORANGE;
    }
    return ColorManager.WHITE;
  }

  void getFieldIdByCache() async {
    var fieldData = await SecureStorage.instance.readFieldModel('outLineField');
    setState(() {
      fieldId = fieldData?.id ?? 0;
    });
  }

  @override
  void initState() {
    getFieldIdByCache();
    super.initState();
  }

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
                child: AppCalendar(
                  format: CalendarFormat.month,
                  headerVisible: true,
                  rowHeight: 12,
                  fieldIslemData: widget.fieldIslemData,
                  isVisibleEventText: true,
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contexy) {
                          return IslemlerEkleme(
                            //image: ImageManager.instance.sulama,
                            fieldId: fieldId,
                            islemField: true,
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.fieldIslemData?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: context.padding.onlyTopLow,
                    child: IslermlerCardWidget(
                      color: markerColors(widget.fieldIslemData?[index].islemTipi ?? ""),
                      fieldIslemData: widget.fieldIslemData?[index],
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
