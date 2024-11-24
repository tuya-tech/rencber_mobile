import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:sizer/sizer.dart';

class AdviceView extends StatelessWidget {
  const AdviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.BGCOLOR,
      body: SliverAppBarCustom(
        height: 15,
        title: Text("Tavsiyeler", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.WHITE)),
        child: Padding(
          padding: context.padding.onlyTopLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: context.padding.onlyLeftNormal, child: Text("Aydınlı", style: context.general.textTheme.titleMedium)),
              SizedBox(
                height: 45.w,
                width: 100.w,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: context.padding.onlyLeftNormal + context.padding.onlyBottomNormal,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 45.w,
                      width: 70.w,
                      child: Card(
                        color: ColorManager.WHITE,
                        child: ListTile(title: Text("Haber $index")),
                      ),
                    );
                  },
                ),
              ),
              Padding(padding: context.padding.onlyLeftNormal, child: Text("Size Özel Öneriler", style: context.general.textTheme.titleMedium)),
              SizedBox(
                height: 60.w,
                width: 100.w,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: context.padding.onlyLeftNormal + context.padding.onlyBottomNormal,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 60.w,
                      width: 40.w,
                      child: Card(
                        color: ColorManager.WHITE,
                        child: ListTile(title: Text("Haber $index")),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
