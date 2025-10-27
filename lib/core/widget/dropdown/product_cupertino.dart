import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/product/provider/product/product.dart';
import 'package:sizer/sizer.dart';

class AppProductsCupertino extends ConsumerStatefulWidget {
  const AppProductsCupertino({
    super.key,
    required this.productController,
    required this.labelText,
    required this.productIdController,
  });

  final TextEditingController productController;
  final String labelText;
  final TextEditingController productIdController;

  @override
  ConsumerState<AppProductsCupertino> createState() => _AppProductsCupertinoState();
}

class _AppProductsCupertinoState extends ConsumerState<AppProductsCupertino> {
  String? selectedProduct;

  @override
  Widget build(BuildContext context) {
    var bitkiList = ref.watch(productFutureProvider).asData?.value.data ?? [];

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
                if (bitkiList.isEmpty) return;

                showCupertinoModalPopup(
                  context: context,
                  builder: (_) => Container(
                    height: 250,
                    color: ColorManager.white,
                    child: CupertinoPicker(
                      itemExtent: 32,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedProduct != null
                            ? bitkiList.indexWhere((e) => e.name == selectedProduct)
                            : 0,
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedProduct = bitkiList[index].name;
                          widget.productController.text = selectedProduct!;
                          widget.productIdController.text =
                              bitkiList[index].id.toString();
                        });
                      },
                      children: bitkiList
                          .map((e) => Center(
                                child: Text(
                                  e.name ?? 'error',
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
                  selectedProduct ?? "Mahsül Seçiniz",
                  style: context.general.textTheme.titleMedium!.copyWith(
                    color: selectedProduct == null
                        ? Colors.grey
                        : ColorManager.black,
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
