import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/constant/constant.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/button/eleveted_button.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:sizer/sizer.dart';

class AppDatePicker extends ConsumerStatefulWidget {
  const AppDatePicker({super.key, required this.controller, this.hintText, required this.name, this.labelText, this.isBorder = false, this.onPressed, this.initialValue = ""});
  final String name;
  final String? hintText;
  final String? labelText;
  final bool isBorder;
  final void Function()? onPressed;
  final TextEditingController controller;
  final String? initialValue;

  @override
  ConsumerState<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends ConsumerState<AppDatePicker> {
  late final TextEditingController controller;
  late DateTime timePicker;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    timePicker = DateTime.now();
    controller = TextEditingController(text: widget.initialValue);
    debugPrint("widget.initialValue: ${widget.initialValue}");
    debugPrint("controller.text: ${controller.text}");
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = AppConstant.convertDottedDateToText(widget.initialValue ?? "");
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(widget.isBorder ? 10 : 24),
        //border: Border.all(color: ColorManager.black.withValues(alpha: 0.1)),
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
        child: InkWell(
          onTap: widget.labelText == null
              ? () {
                  setState(() {
                    isEdit = false;
                  });
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: ColorManager.white,
                            elevation: 0,
                            content: SizedBox(
                              height: 60.w,
                              width: 100.w,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ScrollDatePicker(
                                      maximumDate: DateTime.now(),
                                      minimumDate: DateTime(1900),
                                      viewType: const [
                                        DatePickerViewType.day,
                                        DatePickerViewType.month,
                                        DatePickerViewType.year,
                                      ],
                                      scrollViewOptions: DatePickerScrollViewOptions(
                                        day: ScrollViewDetailOptions(margin: EdgeInsets.only(right: 5.w)),
                                        month: const ScrollViewDetailOptions(margin: EdgeInsets.zero, label: " "),
                                        year: ScrollViewDetailOptions(margin: EdgeInsets.only(left: 5.w)),
                                      ),
                                      selectedDate: timePicker,
                                      onDateTimeChanged: (value) {
                                        setState(() {
                                          timePicker = value;
                                        });
                                      },
                                      locale: const Locale("tr", "TR"),
                                    ),
                                  ),
                                  context.sized.emptySizedHeightBoxLow,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppElevetedButton(
                                          buttonwidth: 30,
                                          buttonHeight: 10,
                                          buttonText: "Geri",
                                          onPressed: () {
                                            setState(() {
                                              isEdit = false;
                                            });
                                            Navigator.pop(context);
                                          }),
                                      AppElevetedButton(
                                        buttonwidth: 30,
                                        buttonHeight: 10,
                                        buttonText: "Tamam",
                                        onPressed: () {
                                          setState(() {});
                                          widget.controller.text = timePicker.toString();
                                          controller.text = AppConstant.dateFormat(context, timePicker.toString()) ?? "";
                                          isEdit = false;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: context.padding.onlyLeftLow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.labelText != null) Text(widget.labelText ?? "", style: context.general.textTheme.titleMedium),
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       isEdit = false;
                    //     });
                    //     showDialog(
                    //       barrierDismissible: false,
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return StatefulBuilder(
                    //           builder: (context, setState) {
                    //             return AlertDialog(
                    //               backgroundColor: ColorManager.white,
                    //               elevation: 0,
                    //               content: SizedBox(
                    //                 height: 60.w,
                    //                 width: 100.w,
                    //                 child: Column(
                    //                   children: [
                    //                     Expanded(
                    //                       child: ScrollDatePicker(
                    //                         maximumDate: DateTime.now(),
                    //                         minimumDate: DateTime(1900),
                    //                         viewType: const [
                    //                           DatePickerViewType.day,
                    //                           DatePickerViewType.month,
                    //                           DatePickerViewType.year,
                    //                         ],
                    //                         scrollViewOptions: DatePickerScrollViewOptions(
                    //                           day: ScrollViewDetailOptions(margin: EdgeInsets.only(right: 5.w)),
                    //                           month: const ScrollViewDetailOptions(margin: EdgeInsets.zero, label: " "),
                    //                           year: ScrollViewDetailOptions(margin: EdgeInsets.only(left: 5.w)),
                    //                         ),
                    //                         selectedDate: timePicker,
                    //                         onDateTimeChanged: (value) {
                    //                           setState(() {
                    //                             timePicker = value;
                    //                           });
                    //                         },
                    //                         locale: const Locale("tr", "TR"),
                    //                       ),
                    //                     ),
                    //                     context.sized.emptySizedHeightBoxLow,
                    //                     Row(
                    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         AppElevetedButton(
                    //                             buttonwidth: 30,
                    //                             buttonHeight: 10,
                    //                             buttonText: "Geri",
                    //                             onPressed: () {
                    //                               setState(() {
                    //                                 isEdit = false;
                    //                               });
                    //                               Navigator.pop(context);
                    //                             }),
                    //                         AppElevetedButton(
                    //                           buttonwidth: 30,
                    //                           buttonHeight: 10,
                    //                           buttonText: "Tamam",
                    //                           onPressed: () {
                    //                             setState(() {});
                    //                             widget.controller.text = timePicker.toString();
                    //                             controller.text = AppConstant.dateFormat(context, timePicker.toString()) ?? "";
                    //                             isEdit = false;
                    //                             Navigator.pop(context);
                    //                           },
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         );
                    //       },
                    //     );
                    //   },
                    //   child: widget.labelText != null ? IconManager.instance.customIcon(Icons.edit_outlined) : const SizedBox.shrink(),
                    // ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: ColorManager.white,
                            elevation: 0,
                            content: SizedBox(
                              height: 60.w,
                              width: 100.w,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ScrollDatePicker(
                                      maximumDate: DateTime.now(),
                                      minimumDate: DateTime(1900),
                                      viewType: const [
                                        DatePickerViewType.day,
                                        DatePickerViewType.month,
                                        DatePickerViewType.year,
                                      ],
                                      scrollViewOptions: DatePickerScrollViewOptions(
                                        day: ScrollViewDetailOptions(margin: EdgeInsets.only(right: 5.w)),
                                        month: const ScrollViewDetailOptions(margin: EdgeInsets.zero, label: " "),
                                        year: ScrollViewDetailOptions(margin: EdgeInsets.only(left: 5.w)),
                                      ),
                                      selectedDate: timePicker,
                                      onDateTimeChanged: (value) {
                                        setState(() {
                                          timePicker = value;
                                        });
                                      },
                                      locale: const Locale("tr", "TR"),
                                    ),
                                  ),
                                  context.sized.emptySizedHeightBoxLow,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppElevetedButton(
                                          buttonwidth: 30,
                                          buttonHeight: 10,
                                          buttonText: "Geri",
                                          onPressed: () {
                                            setState(() {
                                              isEdit = false;
                                            });
                                            Navigator.pop(context);
                                          }),
                                      AppElevetedButton(
                                        buttonwidth: 30,
                                        buttonHeight: 10,
                                        buttonText: "Tamam",
                                        onPressed: () {
                                          setState(() {});
                                          widget.controller.text = timePicker.toString();
                                          controller.text = AppConstant.dateFormat(context, timePicker.toString()) ?? "";
                                          isEdit = false;
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: FormBuilderTextField(
                  controller: controller,
                  enabled: isEdit,
                  name: widget.name,
                  style: context.general.textTheme.titleMedium,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    contentPadding: EdgeInsets.only(left: 2.w, top: widget.labelText == null ? 3.w : 0),
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    suffixIcon: widget.labelText == null ? IconManager.instance.customIcon(Icons.calendar_today_outlined) : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
