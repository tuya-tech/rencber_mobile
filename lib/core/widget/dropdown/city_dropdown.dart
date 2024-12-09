import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/dropdown/main_dropdown.dart';
import 'package:rencber_mobile/product/provider/location/location_provider.dart';

class AppCityDropdown extends ConsumerStatefulWidget {
  const AppCityDropdown({super.key, required this.controller, this.onSelected, this.hintText});
  final TextEditingController controller;
  final void Function(String, int)? onSelected;
  final String? hintText;

  @override
  ConsumerState<AppCityDropdown> createState() => _AppCityDropdownState();
}

class _AppCityDropdownState extends ConsumerState<AppCityDropdown> {
  List<dynamic> cityList = [];

  int getCityIdByName(String cityName) {
    if (cityList.ext.isNotNullOrEmpty) {
      return cityList.firstWhere((element) => element["name"] == cityName)["id"];
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cityList.ext.isNullOrEmpty) cityList = ref.watch(cityFutureProvider).asData?.value ?? [];
    return DropDownSearchField(
      textFormFieldvalidator: (value) {
        if (value.toString().ext.isNullOrEmpty) {
          return "Bu alan boş bırakılamaz";
        }
        return null;
      },
      controller: widget.controller,
      items: cityList.map((e) => e['name'] as String).toList(),
      itemBuilder: (context, item) => Padding(padding: context.padding.low, child: Text(item, style: context.general.textTheme.titleMedium)),
      menuDecoration: BoxDecoration(
        color: ColorManager.WHITE,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1)),
        ],
      ),
      textFormFieldstyle: context.general.textTheme.titleMedium,
      textFormFieldDecoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconManager.instance.customIcon(Icons.keyboard_arrow_down),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.GREEN),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.RED),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.RED),
        ),
      ),
      onSelected: (value) {
        var cityId = getCityIdByName(value);
        widget.onSelected!(value, cityId);
      },
    );
  }
}
