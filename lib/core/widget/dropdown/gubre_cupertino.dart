import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:sizer/sizer.dart';

class AppGubreCupertino extends StatefulWidget {
  const AppGubreCupertino({super.key, required this.gubreController, required this.labelText});

  final TextEditingController gubreController;
  final String labelText;

  @override
  State<AppGubreCupertino> createState() => _AppGubreCupertinoState();
}

class _AppGubreCupertinoState extends State<AppGubreCupertino> {
  final List<String> gubreList = ["Katı Gübre", "Sıvı Gübre"];
  String? selectedGubre;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Padding(
              padding: context.padding.onlyLeftLow,
              child: Text(
                widget.labelText,
                style: context.general.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 1.h),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) => Container(
                    height: 200,
                    color: ColorManager.white,
                    child: CupertinoPicker(
                      itemExtent: 32,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedGubre != null ? gubreList.indexOf(selectedGubre!) : 0,
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedGubre = gubreList[index];
                          widget.gubreController.text =
                              selectedGubre == "Katı Gübre" ? "KATI" : "SIVI";
                        });
                      },
                      children: gubreList
                          .map((e) => Center(
                                child: Text(
                                  e,
                                  style: context.general.textTheme.titleMedium,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorManager.greyColor),
                  color: ColorManager.white,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedGubre ?? "Gübre Seçiniz",
                  style: context.general.textTheme.titleMedium!.copyWith(
                    color: selectedGubre == null ? Colors.grey : ColorManager.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
