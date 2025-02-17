import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:rencber_mobile/core/widget/checkbox/checkbox.dart';
import 'package:rencber_mobile/core/widget/date_picker/date_picker.dart';
import 'package:rencber_mobile/core/widget/dropdown/gubre_dropdown.dart';
import 'package:rencber_mobile/core/widget/dropdown/product_dropdown.dart';
import 'package:rencber_mobile/core/widget/switch/switch.dart';
import 'package:rencber_mobile/core/widget/text_field/custom_text_field.dart';
import 'package:rencber_mobile/features/fields/mixin/add_mixin.dart';
import 'package:rencber_mobile/features/profile/view/profile_edit.dart';
import 'package:rencber_mobile/product/provider/location/location_provider.dart';

class FieldAddView extends ConsumerStatefulWidget {
  const FieldAddView({super.key});

  @override
  ConsumerState<FieldAddView> createState() => _FieldAddViewState();
}

class _FieldAddViewState extends ConsumerState<FieldAddView> with FieldAddMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 5,
        title: Text("Tarla Ekle", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
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
              AppProducts(productController: productController, labelText: "Mahsül Bilgisi*"),
              context.sized.emptySizedHeightBoxLow,
              AppDatePicker(controller: dateTimeController, name: "dateTime", hintText: "--,--,----", labelText: "Ekim Yapılma Tarihi*", initialValue: AppConstant.dateFormat(context, dateTimeController.text)),
              context.sized.emptySizedHeightBoxLow,
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.WHITE,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.BLACK.withValues(alpha: 0.1),
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
                onChanged: (value) {
                  debugPrint("value: $value");
                  setState(() {
                    outline = value!;
                  });
                },
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
