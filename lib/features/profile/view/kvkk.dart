import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:rencber_mobile/core/constants/color/color.dart';
import 'package:rencber_mobile/core/widget/appbar/back_appbar.dart';
import 'package:rencber_mobile/core/widget/appbar/sliver_appbar.dart';

class KvkkView extends StatefulWidget {
  const KvkkView({super.key});

  @override
  State<KvkkView> createState() => _KvkkViewState();
}

class _KvkkViewState extends State<KvkkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.bgColor,
      body: SliverAppBarCustom(
        height: 5,
        title: Text("KVKK", style: context.general.textTheme.headlineMedium?.copyWith(color: ColorManager.white)),
        leading: const AppBarBackButton(),
        child: Padding(
          padding: context.padding.normal + context.padding.onlyBottomHigh,
          child: const Text(
              '''Rençber, zirai faaliyetlerinizi en verimli şekilde planlamanıza yardımcı olan akıllı bir mobil uygulamadır. Tarla konumunuza ve mahsullerinize göre Meteoroloji Genel Müdürlüğü'nden aldığı güncel hava tahminlerini kullanarak gübreleme, ilaçlama, sulama ve çapalama önerilerinde bulunur. Yağış, rüzgâr gibi hava olaylarını takip eder sel, don gibi afetler hakkında sizi uyarır. Çalışmanız için en uygun zaman aralığını sizin için tespit eder. Eğer bu zaman aralığını kaçırırsanız, en uygun yeni zaman aralığını sizin için belirleyip hatırlatır.
              
Rençber ayrıca mahsul bilgilerinize göre uygun fiyatlı gübre ve ilaç tavsiyelerinde bulunur, bu ürünleri kolayca temin edebileceğiniz en yakın bayilere sizi yönlendirir. Yakında toprak analizi ve iklim değişikliği raporları gibi ileri seviye hizmetlerle de size destek olmaya başlayacak.
Rençber ile tarlanızın ihtiyacına uygun şekilde, doğru zamanda hareket edin; mahsullerinizin verimini ve kalitesini artırın!

Bir Aydınlı Biyoteknoloji A.Ş. ürünü © 2025 '''),
        ),
      ),
    );
  }
}
