import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/dropdown/main_dropdown.dart';
import 'package:sizer/sizer.dart';

class AppGubre extends StatefulWidget {
  const AppGubre({super.key, required this.gubreController, required this.labelText});
  final TextEditingController gubreController;
  final String labelText;

  @override
  State<AppGubre> createState() => _AppGubreState();
}

class _AppGubreState extends State<AppGubre> {
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
          children: [
            Padding(
              padding: context.padding.onlyLeftLow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.labelText, style: context.general.textTheme.titleMedium),
                  // InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         isEdit = !isEdit;
                  //         if (isEdit) {
                  //           WidgetsBinding.instance.addPostFrameCallback((_) {
                  //             focusNode.requestFocus();
                  //           });
                  //         } else {
                  //           focusNode.unfocus();
                  //         }
                  //       });
                  //     },
                  //     child: IconManager.instance.customIcon(!isEdit ? Icons.edit_outlined : Icons.check)),
                ],
              ),
            ),
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
              child: DropDownSearchField(
                focusNode: focusNode,
                enabled: isEdit,
                textMode: true,
                controller: widget.gubreController,
                items: const ["Katı Gübre", "Sıvı Gübre"],
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
                  contentPadding: EdgeInsets.only(left: 2.w),
                  hintText: "Gübre Seçiniz",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                onSelected: (value) {
                  if (value == "Katı Gübre") {
                    widget.gubreController.text = "KATI";
                  } else {
                    widget.gubreController.text = "SIVI";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
