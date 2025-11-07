import 'package:flutter/material.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.items,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
  });

  /// Key-Value Map (örnek: {'SULAMA': 'Sulama'})
  final Map<String, String> items;

  /// Dropdown placeholder
  final String? hintText;

  /// Label üzerinde gösterilecek metin
  final String? labelText;

  /// Başlangıçta seçili olacak key
  final String? initialValue;

  /// Seçim yapıldığında çağrılacak callback
  final void Function(String key, String value)? onChanged;

  /// Kenar yuvarlaklığı (varsayılan 16)
  final double? borderRadius;

  /// İç arka plan rengi (varsayılan: beyaz)
  final Color? fillColor;

  /// Kenar rengi (varsayılan: ColorManager.green)
  final Color? borderColor;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? _selectedKey;

  @override
  void initState() {
    super.initState();
    _selectedKey = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedKey,
      decoration: InputDecoration(
        hintText: widget.hintText ?? "Seçiniz",
        filled: true,
        fillColor: ColorManager.white,
        suffixIcon: IconManager.instance.customIcon(Icons.keyboard_arrow_down),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: widget.borderColor ?? ColorManager.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: widget.borderColor ?? ColorManager.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: widget.borderColor ?? ColorManager.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: widget.borderColor ?? ColorManager.green),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: widget.borderColor ?? ColorManager.green),
        ),
      ),
      dropdownColor: widget.fillColor ?? ColorManager.white,
      borderRadius: BorderRadius.circular(8),
      items: widget.items.entries
          .map(
            (entry) => DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.value),
            ),
          )
          .toList(),
      onChanged: (key) {
        setState(() {
          _selectedKey = key;
        });
        if (key != null && widget.onChanged != null) {
          final value = widget.items[key] ?? "";
          widget.onChanged!(key, value);
        }
      },
    );
  }
}
