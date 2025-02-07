import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/dropdown/main_dropdown.dart';
import 'package:rencber_mobile/product/provider/product/product.dart';
import 'package:sizer/sizer.dart';

class AppProducts extends ConsumerStatefulWidget {
  const AppProducts({super.key, required this.productController, required this.labelText});
  final TextEditingController productController;
  final String labelText;

  @override
  ConsumerState<AppProducts> createState() => _AppProductsState();
}

class _AppProductsState extends ConsumerState<AppProducts> {
  late FocusNode focusNode;
  bool isEdit = false;
  bool isValide = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var bitki = ref.watch(productFutureProvider).asData?.value.data ?? [];
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
        child: Column(
          children: [
            Padding(
              padding: context.padding.onlyLeftLow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.labelText, style: context.general.textTheme.titleMedium),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isEdit = !isEdit;
                          if (isEdit) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              focusNode.requestFocus();
                            });
                          } else {
                            focusNode.unfocus();
                          }
                        });
                      },
                      child: IconManager.instance.customIcon(!isEdit ? Icons.edit_outlined : Icons.check)),
                ],
              ),
            ),
            DropDownSearchField(
              focusNode: focusNode,
              enabled: isEdit,
              textMode: true,
              controller: widget.productController,
              items: bitki.map((e) => e.name).toList(),
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
                contentPadding: EdgeInsets.only(left: 2.w),
                hintText: "Mahsül Bilgileri",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              onSelected: (value) {
                debugPrint(value);
                widget.productController.text = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
