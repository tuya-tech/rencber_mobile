import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/features/fields/view/field_detail.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:sizer/sizer.dart';

class FieldCard extends StatelessWidget {
  const FieldCard({super.key, this.field, this.isDetail = false});
  final FieldResponseModel? field;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.w,
      width: 85.w,
      child: Card(
        color: ColorManager.white,
        child: Padding(
          padding: context.padding.low,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ImageManager.instance.tarla,
              ImageManager.instance.getTarlaResimByBitki(field?.bitkiName),
              context.sized.emptySizedWidthBoxLow,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 42.w, child: Text("${field?.name}", style: context.general.textTheme.titleSmall)),
                  Text("${field?.bitkiName}", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.textGreyColor)),
                  Row(
                    children: [
                      Container(
                        height: 5.w,
                        width: 5.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: ColorManager.greyColor, width: 0.5),
                        ),
                        child: IconManager.instance.customIcon(Icons.calendar_month_outlined, color: ColorManager.purple, sizeW: 3.5),
                      ),
                      context.sized.emptySizedWidthBoxLow,
                      Text("Gün : ${field?.day}", style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.textGreyColor)),
                    ],
                  ),
                  SizedBox(height: 1.w),
                  Row(
                    children: [
                      Container(
                          height: 5.w,
                          width: 5.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: ColorManager.greyColor, width: 0.5),
                          ),
                          child: Center(child: ImageManager.instance.evre)),
                      context.sized.emptySizedWidthBoxLow,
                      SizedBox(
                        width: 35.w,
                        child: Text(
                          "Evre : ${field?.buyumeTipi}",
                          style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.textGreyColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.w),
                  Container(
                    decoration: BoxDecoration(color: ColorManager.containerGrey, borderRadius: BorderRadius.circular(4)),
                    padding: context.padding.onlyLeftLow + context.padding.onlyRightLow,
                    child: Text(
                      "${field?.district?.name}, ${field?.city?.name}",
                      style: context.general.textTheme.bodyLarge?.copyWith(color: ColorManager.textGreyColor),
                    ),
                  ),
                ],
              ),
              FieldMoreVert(field: field, isDetail: isDetail),
            ],
          ),
        ),
      ),
    );
  }
}

class FieldMoreVert extends StatelessWidget {
  const FieldMoreVert({super.key, this.field, required this.isDetail});
  final FieldResponseModel? field;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: ColorManager.white,
      padding: EdgeInsets.zero,
      menuPadding: EdgeInsets.zero,
      offset: const Offset(0, 27),
      onSelected: (value) {
        if (value == 1) {
          PersistentNavBarNavigator.pushNewScreen(context, screen: FieldDetailView(fieldId: field?.id ?? 0));
        } else if (value == 2) {
          context.push(RouterManager.editField, extra: field);
        }
      },
      itemBuilder: (context) {
        return isDetail == false
            ? [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tarla Bilgileri", style: context.general.textTheme.labelLarge),
                      IconManager.instance.customIcon(Icons.chevron_right_rounded, color: ColorManager.black, sizeW: 5),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tarla Düzenle", style: context.general.textTheme.labelLarge),
                      IconManager.instance.customIcon(Icons.chevron_right_rounded, color: ColorManager.black, sizeW: 5),
                    ],
                  ),
                ),
              ]
            : [
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tarla Düzenle", style: context.general.textTheme.labelLarge),
                      IconManager.instance.customIcon(Icons.chevron_right_rounded, color: ColorManager.black, sizeW: 5),
                    ],
                  ),
                ),
              ];
      },
      child: IconManager.instance.customIcon(Icons.more_horiz, color: ColorManager.black, sizeW: 5),
    );
  }
}
