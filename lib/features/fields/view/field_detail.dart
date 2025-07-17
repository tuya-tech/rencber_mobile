// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/button/right_icon_button.dart';
import 'package:rencber_mobile/core/widget/date_picker/date_picker.dart';
import 'package:rencber_mobile/core/widget/dropdown/custom_dropdown.dart';
import 'package:rencber_mobile/core/widget/loading/loading.dart';
import 'package:rencber_mobile/core/widget/toastr/toastr.dart';
import 'package:rencber_mobile/features/fields/widget/field_card.dart';
import 'package:rencber_mobile/features/fields/widget/islemler.dart';
import 'package:rencber_mobile/product/models/field/field_islem_response.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/provider/field/field.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:rencber_mobile/product/services/field/field_islem_service.dart';
import 'package:sizer/sizer.dart';

class FieldDetailView extends ConsumerStatefulWidget {
  const FieldDetailView({super.key, required this.fieldId});
  final int fieldId;

  @override
  ConsumerState<FieldDetailView> createState() => _FieldDetailViewState();
}

class _FieldDetailViewState extends ConsumerState<FieldDetailView> {
  Color markerColors(String selectedDay) {
    if (selectedDay == 'SULAMA') {
      return ColorManager.blue;
    } else if (selectedDay == 'GUBRELEME') {
      return ColorManager.brown;
    } else if (selectedDay == 'CAPALAMA') {
      return ColorManager.orange;
    }
    return ColorManager.white;
  }

  @override
  Widget build(BuildContext context) {
    var fieldProvider = ref.watch(fieldIdFutureProvider(widget.fieldId));
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: fieldProvider.when(
        data: (fieldData) {
          //var field = fieldData.data;
          var field = fieldData['fieldById'] != null ? fieldData['fieldById'] as FieldResponseModel : FieldResponseModel();
          var fieldIslemData = fieldData['fieldIslem'] != null ? fieldData['fieldIslem'] as List<FieldIslemResponseModel> : List<FieldIslemResponseModel>.empty();
          return SliverAppBarCustom(
            height: 5,
            title: Text(field.name ?? "", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
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
                      IslemlerWidget(
                        borderColor: ColorManager.blue,
                        image: ImageManager.instance.sulama,
                        title: "Sulama",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (contexy) {
                              return IslemlerEkleme(image: ImageManager.instance.sulama, islemTipi: "SULAMA", fieldId: widget.fieldId);
                            },
                          );
                        },
                      ),
                      IslemlerWidget(
                        borderColor: ColorManager.orange,
                        image: ImageManager.instance.capalama,
                        title: "Çapalama",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (contexy) {
                              return IslemlerEkleme(image: ImageManager.instance.capalama, islemTipi: "CAPALAMA", fieldId: widget.fieldId);
                            },
                          );
                        },
                      ),
                      IslemlerWidget(
                        borderColor: ColorManager.brown,
                        image: ImageManager.instance.gubreleme,
                        title: "Gübreleme",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (contexy) {
                              return IslemlerEkleme(image: ImageManager.instance.gubreleme, islemTipi: "GUBRELEME", fieldId: widget.fieldId);
                            },
                          );
                        },
                      ),
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
                      itemCount: fieldIslemData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: context.padding.onlyRightNormal,
                          child: IslermlerCardWidget(color: markerColors(fieldIslemData[index].islemTipi ?? ""), fieldIslemData: fieldIslemData[index]),
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

class IslemlerEkleme extends ConsumerStatefulWidget {
  const IslemlerEkleme({super.key, this.image, this.islemTipi, required this.fieldId, this.islemField = false});
  final Widget? image;
  final String? islemTipi;
  final int fieldId;
  final bool islemField;

  @override
  ConsumerState<IslemlerEkleme> createState() => _IslemlerEklemeState();
}

class _IslemlerEklemeState extends ConsumerState<IslemlerEkleme> {
  late final TextEditingController _controller;
  final List<String> items = ["Sulama", "Çapalama", "Gübreleme"];
  late final TextEditingController _dropdownController;

  String islemTipiConvert(String islemTipi) {
    if (islemTipi == "Sulama") {
      return "SULAMA";
    } else if (islemTipi == "Çapalama") {
      return "CAPALAMA";
    } else if (islemTipi == "Gübreleme") {
      return "GUBRELEME";
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _dropdownController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.bgColor,
      content: SizedBox(
        height: widget.islemField ? 72.w : 70.w,
        width: 100.w,
        child: Column(
          spacing: 2.w,
          children: [
            if (widget.image != null) widget.image!,
            const Text("Lütfen işlem tarihini seçiniz"),
            if (widget.islemField)
              AppCustomDropdown(
                controller: _dropdownController,
                items: items,
                hintText: "İşlem Tipi",
                borderColor: ColorManager.white,
                onSelected: (p0) {
                  _dropdownController.text = islemTipiConvert(p0);
                },
              ),
            AppDatePicker(
              isBorder: true,
              name: "islemAdd",
              controller: _controller,
              initialValue: AppConstant.setDateTimeFormat(context, "dd.MM.yyyy", null),
            ),
            context.sized.emptySizedHeightBoxLow,
            AppElevetedButton(
              buttonHeight: 10,
              buttonText: "Kaydet",
              onPressed: () async {
                debugPrint("islemTipi: ${widget.islemTipi == null ? _dropdownController.text : widget.islemTipi!}");
                appLoading(context, true);
                var response = await FieldIslemApiService.instance.post(
                  widget.islemTipi == null ? _dropdownController.text : widget.islemTipi!,
                  true,
                  widget.fieldId,
                  AppConstant.setDateTimeFormat(context, "yyyy-MM-dd", _controller.text.ext.isNotNullOrNoEmpty ? _controller.text : DateTime.now().toString()),
                );
                if (response.statusCode == 201 && context.mounted) {
                  ref.invalidate(fieldIdFutureProvider(widget.fieldId));
                  Toastr.showSuccess("İşleminiz başarıyla eklendi.", context);
                  Navigator.pop(context);
                  appLoading(context, false);
                } else {
                  appLoading(context, false);
                  Toastr.showError(response.message.toString(), context);
                }
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text("İptal", style: context.general.textTheme.bodyMedium?.copyWith(color: ColorManager.buttonRedColor)),
            ),
          ],
        ),
      ),
    );
  }
}

class IslermlerCardWidget extends StatelessWidget {
  const IslermlerCardWidget({super.key, required this.color, this.fieldIslemData});
  final Color color;
  final FieldIslemResponseModel? fieldIslemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.w,
      height: 30.w,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.bgColor, width: 1.5),
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
                Text((fieldIslemData?.islemTipi ?? "").ext.toCapitalized(), style: context.general.textTheme.labelMedium?.copyWith(color: color)),
                context.sized.emptySizedHeightBoxLow,
                if (fieldIslemData?.startDate == AppConstant.setDateTimeFormat(context, "dd.MM.yyyy", null))
                  Text(
                    "Bugün ${(fieldIslemData?.islemTipi ?? "").ext.toCapitalized()} işlemi yapılacak.",
                    style: context.general.textTheme.labelLarge?.copyWith(color: color, fontSize: 14.sp),
                  ),
                if (fieldIslemData?.startDate != AppConstant.setDateTimeFormat(context, "dd.MM.yyyy", null))
                  Text(
                    "${(fieldIslemData?.islemTipi ?? "").ext.toCapitalized()} işlemi yapıldı.",
                    style: context.general.textTheme.labelLarge?.copyWith(color: color, fontSize: 14.sp),
                  ),
                //Text("Bugün ${(fieldIslemData?.islemTipi ?? "").ext.toCapitalized()} işlemi yapılacak", style: context.general.textTheme.labelLarge?.copyWith(color: color, fontSize: 14.sp)),
                context.sized.emptySizedHeightBoxLow,
                Row(
                  children: [
                    IconManager.instance.customIcon(Icons.calendar_month, color: color, sizeW: 6),
                    context.sized.emptySizedWidthBoxLow,
                    Text(fieldIslemData?.startDate ?? "", style: context.general.textTheme.labelLarge?.copyWith(color: color)),
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
