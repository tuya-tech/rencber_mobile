import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/product/models/user/user_response.dart';

class NotificationSettingView extends StatefulWidget {
  const NotificationSettingView({super.key, required this.userResponse});
  final UserResponseModel userResponse;

  @override
  State<NotificationSettingView> createState() => _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<NotificationSettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 5,
        title: Text("Bildirim Tercihleri", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        leading: const AppBarBackButton(),
        child: Padding(
          padding: context.padding.normal + context.padding.onlyBottomHigh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationSwitch(
                title: "Genel",
                subtitle: "Anlık Bildirim Al",
                initialValue: widget.userResponse.sendAd,
                onChanged: (value) {},
              ),
              context.sized.emptySizedHeightBoxLow,
              NotificationSwitch(title: "SMS", subtitle: "SMS'lere izin ver", initialValue: widget.userResponse.sendAd, onChanged: (value) {}),
              context.sized.emptySizedHeightBoxLow,
              NotificationSwitch(title: "E-posta", subtitle: "E-postalara izin ver", initialValue: widget.userResponse.sendAd, onChanged: (value) {}),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationSwitch extends StatelessWidget {
  const NotificationSwitch({super.key, required this.title, required this.subtitle, this.onChanged, this.initialValue});
  final String title;
  final String subtitle;
  final void Function(bool?)? onChanged;
  final bool? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.WHITE,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.BLACK.withOpacity(0.1),
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
            FormBuilderSwitch(
              name: "notificationSettings",
              title: Text(title, style: context.general.textTheme.labelLarge),
              subtitle: Padding(padding: context.padding.onlyTopLow, child: Text(subtitle, style: context.general.textTheme.titleMedium)),
              activeColor: ColorManager.GREEN,
              activeTrackColor: ColorManager.GREEN.withOpacity(0.5),
              inactiveTrackColor: ColorManager.TEXTGREYCOLOR.withOpacity(0.5),
              inactiveThumbColor: ColorManager.GREYCOLOR.withOpacity(0.5),
              onChanged: onChanged,
              initialValue: initialValue,
              decoration: const InputDecoration(
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
