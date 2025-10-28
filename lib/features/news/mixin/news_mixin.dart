// ignore_for_file: unused_result

import 'dart:core';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/features/news/view/news.dart';
import 'package:rencber_mobile/product/models/news/news_response.dart';

import 'package:rencber_mobile/product/provider/news/news_provider.dart';

mixin NewsMixin on ConsumerState<NewsView> {
  int currentIndex = 0;

  //üst kısımda outline hababerler alt kısımda bütün haberler(autline false ve true)
  (List<NewsResponseModel>, List<NewsResponseModel>) outLineAndNormalData(List<NewsResponseModel> data) {
    // return (data.where((element) => element.outline == true).toList(), data.where((element) => element.outline == false).toList());
    return (data.where((element) => element.outline == true).toList(), data.toList());
  }

  void refreshProvider() {
    ref.refresh(newsFutureProvider);
  }
}
