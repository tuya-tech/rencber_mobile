import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:sizer/sizer.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({super.key, this.multiSelect = false, required this.items, this.onChanged, this.isCircular = false});
  final bool multiSelect;
  final List<String> items;
  final Function(dynamic)? onChanged;
  final bool isCircular;

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  var selectedItem = "";
  var selectedItems = <String>[];

  @override
  Widget build(BuildContext context) {
    return widget.multiSelect
        ? Row(
            children: [
              for (var item in widget.items)
                Padding(
                  padding: context.padding.horizontalLow + context.padding.verticalLow,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                        widget.onChanged!(selectedItem);
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: BoxDecoration(
                            color: selectedItem == item ? ColorManager.GREEN : ColorManager.BGCOLOR,
                            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
                            borderRadius: widget.isCircular ? null : BorderRadius.circular(6),
                            border: Border.all(color: ColorManager.GREYCOLOR, width: 0.5.w),
                          ),
                        ),
                        context.sized.emptySizedWidthBoxLow,
                        Text(item, style: context.general.textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
            ],
          )
        : Column(
            children: [
              for (var item in widget.items)
                Padding(
                  padding: context.padding.horizontalLow + context.padding.onlyBottomLow,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        if (selectedItems.contains(item)) {
                          selectedItems.remove(item);
                        } else {
                          selectedItems.add(item);
                        }

                        List<bool> isSelected = List<bool>.filled(widget.items.length, false);
                        for (var i = 0; i < selectedItems.length; i++) {
                          isSelected[widget.items.indexOf(selectedItems[i])] = true;
                        }
                        widget.onChanged!(isSelected);
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: selectedItems.contains(item) ? ColorManager.GREEN : ColorManager.BGCOLOR,
                            shape: widget.isCircular ? BoxShape.circle : BoxShape.rectangle,
                            borderRadius: widget.isCircular ? null : BorderRadius.circular(6),
                            border: Border.all(color: ColorManager.GREYCOLOR, width: 0.2.w),
                          ),
                          child: selectedItems.contains(item) ? SizedBox(width: 5.5.w, height: 5.5.w, child: IconManager.instance.customIcon(Icons.check, color: ColorManager.WHITE, sizeW: 5)) : SizedBox(width: 5.5.w, height: 5.5.w),
                        ),
                        context.sized.emptySizedWidthBoxLow3x,
                        Expanded(child: Text(item, style: context.general.textTheme.labelLarge?.copyWith(color: ColorManager.GREYCOLOR))),
                      ],
                    ),
                  ),
                ),
            ],
          );
  }
}
