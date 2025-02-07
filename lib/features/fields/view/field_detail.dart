import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/right_icon_button.dart';
import 'package:rencber_mobile/features/fields/widget/field_card.dart';
import 'package:rencber_mobile/features/fields/widget/islemler.dart';
import 'package:rencber_mobile/product/provider/field/field.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class FieldDetailView extends ConsumerWidget {
  const FieldDetailView({super.key, required this.fieldId});
  final int fieldId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fieldProvider = ref.watch(fieldIdFutureProvider(fieldId));
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: fieldProvider.when(
        data: (fieldData) {
          var field = fieldData.data;
          return SliverAppBarCustom(
            height: 5,
            title: Text(field?.name ?? "", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
            leading: const AppBarBackButton(),
            child: Padding(
              padding: context.padding.low,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tarla Bilgileri", style: context.general.textTheme.headlineMedium),
                  context.sized.emptySizedHeightBoxLow,
                  FieldCard(field: field, isDetail: true),
                  context.sized.emptySizedHeightBoxLow3x,
                  Text("İşlemler", style: context.general.textTheme.headlineMedium),
                  context.sized.emptySizedHeightBoxLow,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IslemlerWidget(borderColor: ColorManager.BLUE, image: ImageManager.instance.sulama, title: "Sulama"),
                      IslemlerWidget(borderColor: ColorManager.ORANGE, image: ImageManager.instance.capalama, title: "Çapalama"),
                      IslemlerWidget(borderColor: ColorManager.BROWN, image: ImageManager.instance.gubreleme, title: "Gübreleme"),
                    ],
                  ),
                  context.sized.emptySizedHeightBoxLow3x,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Yapılacak İşlemlerim", style: context.general.textTheme.headlineMedium),
                      AppRightIconButton(
                        onPressed: () {},
                      ),
                    ],
                  ),
                  context.sized.emptySizedHeightBoxLow3x,
                  SizedBox(
                    height: 30.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: context.padding.onlyRightNormal,
                          child: const IslermlerCardWidget(color: ColorManager.BLUE),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          debugPrint("Error: $error");
          return DioErrorManager.dioError(error);
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class IslermlerCardWidget extends StatelessWidget {
  const IslermlerCardWidget({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: ColorManager.WHITE,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.BGCOLOR, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              border: Border.all(color: color, width: 1.5),
            ),
          ),
          context.sized.emptySizedHeightBoxLow,
          Padding(
            padding: context.padding.onlyLeftLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sulama", style: context.general.textTheme.labelMedium?.copyWith(color: color)),
                context.sized.emptySizedHeightBoxLow,
                Text("Sulama işlemi yapılacak", style: context.general.textTheme.labelLarge?.copyWith(color: color, fontSize: 14.sp)),
                context.sized.emptySizedHeightBoxLow,
                Row(
                  children: [
                    IconManager.instance.customIcon(Icons.calendar_month, color: color, sizeW: 6),
                    context.sized.emptySizedWidthBoxLow,
                    Text("07.01.2025", style: context.general.textTheme.labelLarge?.copyWith(color: color)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
