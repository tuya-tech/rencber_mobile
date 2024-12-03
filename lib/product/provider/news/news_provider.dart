import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/news/news_response.dart';
import 'package:rencber_mobile/product/services/news/news.dart';

final newsFutureProvider = FutureProvider.autoDispose<BaseResponseModel<List<NewsResponseModel>>>(
  (ref) async {
    return NewsApiService.instance.get();
  },
);
