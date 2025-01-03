import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/cache/secure_storage.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/constants/icon/icon.dart';
import 'package:rencber_mobile/core/constants/image/image.dart';
import 'package:rencber_mobile/core/router/go_router.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/features/profile/mixin/profile_mixin.dart';
import 'package:rencber_mobile/product/provider/user/user_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    var userIdProvider = ref.watch(userIdFutureProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorManager.BGCOLOR,
      body: userIdProvider.when(data: (userData) {
        var user = userData.data;
        return Stack(
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
                        itemCount: getProfileList(context).length,
                        itemBuilder: (context, index) {
                          var item = getProfileList(context)[index];
                          return ListTile(
                            //contentPadding: EdgeInsets.zero,
                            title: Text(item["title"], style: context.general.textTheme.titleMedium),
                            leading: item["icon"],
                            trailing: IconManager.instance.customIcon(Icons.arrow_forward_ios, sizeW: 5, color: ColorManager.BUTTONBGGREEN),
                            onTap: () => item["onTap"]!(user),
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
                        onTap: () {
                          SecureStorage.instance.deleteSecureData();
                          context.go(RouterManager.login);
                        },
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    context.sized.emptySizedWidthBoxLow3x,
                    ImageManager.instance.women,
                    context.sized.emptySizedWidthBoxLow3x,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 50.w, child: Text("${user?.name} ${user?.surname}", style: context.general.textTheme.labelMedium)),
                        Text("${user?.phone}", style: context.general.textTheme.titleMedium),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }, error: (error, stackTrace) {
        debugPrint("Error: $error");
        return DioErrorManager.dioError(error);
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
