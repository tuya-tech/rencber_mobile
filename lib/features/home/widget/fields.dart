import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/button/right_icon_button.dart';
import 'package:rencber_mobile/features/fields/view/field_detail.dart';
import 'package:rencber_mobile/features/fields/view/fields.dart';
import 'package:rencber_mobile/features/fields/widget/field_card.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:sizer/sizer.dart';

class HomeFieldList extends StatelessWidget {
  const HomeFieldList({super.key, required this.fieldData});
  final List<FieldResponseModel> fieldData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tarlalarım", style: context.general.textTheme.titleSmall),
            AppRightIconButton(onPressed: () {
              fieldData.isNotEmpty ? PersistentNavBarNavigator.pushNewScreen(context, screen: FieldList(fieldData: fieldData)) : null;
            })
          ],
        ),
        context.sized.emptySizedHeightBoxLow,
        SizedBox(
          height: 35.w,
          width: 100.w,
          child: fieldData.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: fieldData.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final fieldData = this.fieldData[index];
                    return InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(context, screen: FieldDetailView(fieldId: fieldData.id ?? 0));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: fieldData.outline == true
                                ? LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorManager.green.withValues(alpha: 0.8),
                                      ColorManager.green.withValues(alpha: 0.5),
                                      ColorManager.green.withValues(alpha: 0.4),
                                      ColorManager.green.withValues(alpha: 0.5),
                                      ColorManager.green.withValues(alpha: 0.8),
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FieldCard(field: fieldData)),
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Henüz tarlanız bulunmamaktadır.",
                      style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.black),
                    ),
                    context.sized.emptySizedHeightBoxLow,
                    TextButton(
                      onPressed: () {
                        context.push(RouterManager.addField);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text("Ekle", style: context.general.textTheme.titleLarge?.copyWith(color: ColorManager.green)),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
