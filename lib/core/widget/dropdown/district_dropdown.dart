import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/dropdown/main_dropdown.dart';
import 'package:rencber_mobile/product/provider/location/location_provider.dart';

class AppDistrictDropdown extends ConsumerStatefulWidget {
  const AppDistrictDropdown({super.key, required this.controller, this.onSelected, this.hintText, this.selectedCityId = 0});
  final TextEditingController controller;
  final void Function(String, int)? onSelected;
  final String? hintText;
  final int selectedCityId;

  @override
  ConsumerState<AppDistrictDropdown> createState() => _AppDistrictDropdownState();
}

class _AppDistrictDropdownState extends ConsumerState<AppDistrictDropdown> {
  List<dynamic> districtList = [];

  int getDistrictIdByName(String districtName) {
    var districtId = districtList.firstWhere((element) => element.name == districtName).id;
    return districtId ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    var selectedCityId = ref.watch(selectedCityIdProvider) as int;
    if (widget.selectedCityId != 0 || selectedCityId != 0) {
      setState(() {
        districtList = ref.watch(districtFutureProvider(selectedCityId != 0 ? selectedCityId : widget.selectedCityId)).asData?.value ?? [];
      });
    }

    return DropDownSearchField(
      textFormFieldvalidator: (value) {
        if (value.toString().ext.isNullOrEmpty) {
          return "Bu alan boş bırakılamaz";
        }
        return null;
      },
      controller: widget.controller,
      items: districtList.map((e) => e.name as String).toList(),
      itemBuilder: (context, item) => Padding(padding: context.padding.low, child: Text(item, style: context.general.textTheme.titleMedium)),
      menuDecoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withValues(alpha: 0.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1)),
        ],
      ),
      textFormFieldstyle: context.general.textTheme.titleMedium,
      textFormFieldDecoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconManager.instance.customIcon(Icons.keyboard_arrow_down),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.red),
        ),
      ),
      onSelected: (value) {
        var districtId = getDistrictIdByName(value);
        widget.onSelected!(value, districtId);
      },
    );
  }
}
