import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/features/profile/mixin/profile_mixin.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.BGCOLOR,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SliverAppBarCustom(
            height: 30,
            title: Text("Hesabım", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 25.w),
                width: 90.w,
                decoration: const BoxDecoration(
                  color: ColorManager.WHITE,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: profileList.length,
                      itemBuilder: (context, index) {
                        var item = profileList[index];
                        return ListTile(
                          //contentPadding: EdgeInsets.zero,
                          title: Text(item["title"], style: context.general.textTheme.titleMedium),
                          leading: item["icon"],
                          trailing: IconManager.instance.customIcon(Icons.arrow_forward_ios, sizeW: 5, color: ColorManager.BUTTONBGGREEN),
                          onTap: item["onTap"]!(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: ColorManager.TEXTGREYCOLOR, indent: 3.w, endIndent: 3.w);
                      },
                    ),
                    Divider(color: ColorManager.TEXTGREYCOLOR, indent: 3.w, endIndent: 3.w),
                    ListTile(
                      //contentPadding: EdgeInsets.zero,
                      title: Text("Çıkış Yap", style: context.general.textTheme.titleMedium?.copyWith(color: ColorManager.TEXTGREYCOLOR)),
                      leading: IconManager.instance.customIcon(Icons.logout, sizeW: 8, color: ColorManager.TEXTGREYCOLOR),
                      //trailing: IconManager.instance.customIcon(Icons.arrow_forward_ios, sizeW: 5, color: ColorManager.TEXTGREYCOLOR),
                      //onTap: item["onTap"]!(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 45.w,
            child: Container(
              height: 30.w,
              width: 90.w,
              decoration: const BoxDecoration(
                color: ColorManager.WHITE,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

              // SecureStorage.instance.deleteSecureData();
              // context.go(RouterManager.login);