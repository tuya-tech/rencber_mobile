import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';
import 'package:rencber_mobile/product/provider/advice/advice_provider.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_error.dart';

class BrandDetailsView extends ConsumerStatefulWidget {
  const BrandDetailsView({super.key, required this.brandId});
  final int brandId;

  @override
  ConsumerState<BrandDetailsView> createState() => _BrandDetailsViewState();
}

class _BrandDetailsViewState extends ConsumerState<BrandDetailsView> {
  @override
  Widget build(BuildContext context) {
    var brandProvider = ref.watch(adviceIdFutureProvider(widget.brandId));
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: brandProvider.when(
        data: (brandData) {
          var brand = brandData.data!;
          return SliverAppBarCustom(
            height: 5,
            leading: const AppBarBackButton(),
            title: Text(brand.title ?? "", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
            child: Html(data: brand.content ?? ""),
          );
        },
        error: (error, stackTrace) {
          debugPrint("Error: $error");
          return DioErrorManager.dioError(error);
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
