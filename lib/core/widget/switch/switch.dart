import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';

class AppSwitch extends StatefulWidget {
  const AppSwitch({super.key, required this.name, required this.label, this.onChanged, this.initialValue});
  final String name;
  final String label;
  final void Function(bool?)? onChanged;
  final bool? initialValue;

  @override
  State<AppSwitch> createState() => _AppSwitchState();
}

class _AppSwitchState extends State<AppSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: FormBuilderSwitch(
          name: widget.name,
          title: Text(widget.label, style: context.general.textTheme.titleMedium),
          onChanged: widget.onChanged,
          initialValue: widget.initialValue,
          activeColor: ColorManager.WHITE,
          inactiveThumbColor: ColorManager.WHITE,
          inactiveTrackColor: ColorManager.GREYCOLOR,
          activeTrackColor: ColorManager.GREEN,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
