import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/dropdown/main_dropdown.dart';

class AppCustomDropdown extends StatefulWidget {
  const AppCustomDropdown({super.key, required this.controller, required this.items, this.onSelected, this.hintText, this.enabled});
  final TextEditingController controller;
  final List<String?> items;
  final void Function(String)? onSelected;
  final String? hintText;
  final bool? enabled;
  @override
  State<AppCustomDropdown> createState() => _AppCustomDropdownState();
}

class _AppCustomDropdownState extends State<AppCustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropDownSearchField(
      enabled: widget.enabled ?? true,
      textFormFieldvalidator: (value) {
        if (value.toString().ext.isNullOrEmpty) {
          return "Bu alan boş bırakılamaz";
        }
        return null;
      },
      controller: widget.controller,
      items: widget.items,
      itemBuilder: (context, item) => Padding(padding: context.padding.low, child: Text(item, style: context.general.textTheme.titleMedium)),
      menuDecoration: BoxDecoration(
        color: ColorManager.WHITE,
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
      onSelected: widget.onSelected,
    );
  }
}
