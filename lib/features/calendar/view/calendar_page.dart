import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/features/calendar/view/calendar.dart';
import 'package:rencber_mobile/product/models/field/field_islem_response.dart';
import 'package:rencber_mobile/product/provider/home/home_provider.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProvider = ref.watch(homeFutureProvider);

    return homeProvider.when(
      data: (homeData) {
        var fieldIslemData = homeData['fieldIslem'] != null 
            ? homeData['fieldIslem'] as List<FieldIslemResponseModel> 
            : List<FieldIslemResponseModel>.empty();
        
        return CalendarView(fieldIslemData: fieldIslemData);
      },
      loading: () => const Scaffold(
        backgroundColor: ColorManager.bgColor,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => const Scaffold(
        backgroundColor: ColorManager.bgColor,
        body: Center(
          child: Text("Takvim verisi yüklenirken hata oluştu"),
        ),
      ),
    );
  }
}
