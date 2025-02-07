import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/features/fields/view/field_detail.dart';
import 'package:rencber_mobile/features/fields/widget/field_card.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:sizer/sizer.dart';

class FieldList extends StatelessWidget {
  const FieldList({super.key, required this.fieldData});
  final List<FieldResponseModel> fieldData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouterManager.addField);
        },
        backgroundColor: ColorManager.GREEN,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: ColorManager.LIGHTGREEN, width: 2),
        ),
        child: IconManager.instance.customIcon(Icons.add, color: ColorManager.WHITE, sizeW: 5),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SliverAppBarCustom(
            height: 30,
            leading: const AppBarBackButton(),
            title: Text("Tarlalarım", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
            //child: const SizedBox.shrink(),
          ),
          Positioned(
            top: 45.w,
            child: SizedBox(
              height: 170.w,
              width: 85.w,
              child: ListView.builder(
                //physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: fieldData.length,
                padding: context.padding.onlyBottomHigh,
                itemBuilder: (context, index) {
                  final fieldData = this.fieldData[index];
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(context, screen: FieldDetailView(fieldId: fieldData.id ?? 0));
                      //context.push(RouterManager.editField, extra: fieldData);
                    },
                    child: FieldCard(field: fieldData, isDetail: true),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
