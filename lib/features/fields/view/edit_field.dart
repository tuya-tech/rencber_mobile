import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/checkbox/checkbox.dart';
import 'package:rencber_mobile/core/widget/date_picker/date_picker.dart';
import 'package:rencber_mobile/core/widget/dropdown/gubre_dropdown.dart';
import 'package:rencber_mobile/core/widget/dropdown/product_dropdown.dart';
import 'package:rencber_mobile/core/widget/switch/switch.dart';
import 'package:rencber_mobile/core/widget/text_field/custom_text_field.dart';
import 'package:rencber_mobile/features/fields/mixin/edit_mixin.dart';
import 'package:rencber_mobile/features/profile/view/profile_edit.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';
import 'package:rencber_mobile/product/provider/location/location_provider.dart';
import 'package:sizer/sizer.dart';

class FieldEditView extends ConsumerStatefulWidget {
  const FieldEditView({super.key, required this.fieldData});
  final FieldResponseModel fieldData;

  @override
  ConsumerState<FieldEditView> createState() => _FieldEditViewState();
}

class _FieldEditViewState extends ConsumerState<FieldEditView> with FieldEditMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: SliverAppBarCustom(
        height: 5,
        title: Text("Tarla Düzenle", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
        leading: const AppBarBackButton(),
        child: Padding(
          padding: context.padding.normal + context.padding.onlyBottomHigh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tarla Bilgileri", style: context.general.textTheme.headlineMedium),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(fieldName: "fieldName", controller: fieldNameController, hintText: "Tarla İsmi Giriniz", labelText: "Tarla İsmi*"),
              context.sized.emptySizedHeightBoxLow,
              AppProducts(productController: productController, labelText: "Mahsül Bilgisi*", productIdController: productIdController),
              context.sized.emptySizedHeightBoxLow,
              AppDatePicker(controller: dateTimeController, name: "dateTime", hintText: "--,--,----", labelText: "Ekim Yapılma Tarihi*", initialValue: dateTimeController.text),
              context.sized.emptySizedHeightBoxLow,
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: context.padding.low,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sulama esnasında gübreleme yapılacak mı?*", style: context.general.textTheme.titleMedium),
                      AppCheckBox(
                        multiSelect: true,
                        items: const ["Evet", "Hayır"],
                        isCircular: true,
                        initialValue: sulamaGubre ? "Evet" : "Hayır",
                        onChanged: (value) {
                          setSulamaGubre(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              AppGubre(gubreController: gubreController, labelText: "Gübre Tercihi*"),
              context.sized.emptySizedHeightBoxLow,
              AppCustomTextField(
                fieldName: "city/district",
                controller: cityDistrictController,
                hintText: "İl / İlçe Seçiniz",
                labelText: "İl/İlçe*",
                buttonOnTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return UserSelectCityAndDistrict(
                        cityController: cityController,
                        districtController: districtController,
                        cityDistrictController: cityDistrictController,
                        initialCityId: 0,
                        selectedCityId: 1,
                        onCitySelected: (val, value) {
                          setState(() {
                            districtController.text = "";
                            cityController.text = val;
                            selectedCityId = value;
                            ref.read(selectedCityIdProvider.notifier).notify(value);
                          });
                        },
                        onDistrictSelected: (val, value) {
                          setState(() {
                            districtController.text = val;
                            selectedDistrictId = value;
                          });
                        },
                      );
                    },
                  );
                },
              ),
              context.sized.emptySizedHeightBoxLow,
              AppSwitch(
                name: "fieldActive",
                label: "Öne Çıkar*",
                initialValue: widget.fieldData.outline ?? false,
                onChanged: (value) {
                  setState(() {
                    outline = value!;
                  });
                },
              ),
              context.sized.emptySizedHeightBoxLow,
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withValues(alpha: 0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: context.padding.low,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tarla Durumu?*", style: context.general.textTheme.titleMedium),
                      InkWell(
                        onTap: () {
                          if (isActive == false) {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: ColorManager.white,
                                child: Container(
                                  height: 40.w,
                                  width: 100.w,
                                  padding: context.padding.low,
                                  decoration: const BoxDecoration(
                                    color: ColorManager.white,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      context.sized.emptySizedHeightBoxLow,
                                      Text("Pasife Al", style: context.general.textTheme.titleLarge),
                                      context.sized.emptySizedHeightBoxLow,
                                      Text(
                                        "Tarlanızı pasife alıyorsunuz bu işlem geri alınamaz!",
                                        style: context.general.textTheme.labelLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      context.sized.emptySizedHeightBoxLow,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppElevetedButton(
                                              buttonColor: ColorManager.buttonRedColor,
                                              buttonText: "Devam Et",
                                              buttonwidth: 10,
                                              buttonHeight: 10,
                                              onPressed: () {
                                                setState(() {
                                                  isActive = true;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          context.sized.emptySizedWidthBoxLow3x,
                                          Expanded(
                                            child: AppElevetedButton(
                                              buttonColor: ColorManager.buttonGreyColor,
                                              buttonText: "İptal",
                                              buttonwidth: 10,
                                              buttonHeight: 10,
                                              textStyle: context.general.textTheme.titleMedium!.copyWith(color: ColorManager.green, fontWeight: FontWeight.bold, fontSize: 16.5.sp),
                                              onPressed: () {
                                                setState(() {
                                                  isActive = false;
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: AbsorbPointer(
                          absorbing: (widget.fieldData.active ?? false),
                          child: AppCheckBox(
                            multiSelect: true,
                            initialValue: widget.fieldData.active == false ? "Ekilmiyor" : "Ekiliyor",
                            items: const ["Ekiliyor", "Ekilmiyor"],
                            isCircular: true,
                            onChanged: (value) {
                              isActive = value == "Ekilmiyor";
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              context.sized.emptySizedHeightBoxLow,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppElevetedButton(buttonwidth: 30, buttonHeight: 9, buttonText: "Kaydet", onPressed: onSaved),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
