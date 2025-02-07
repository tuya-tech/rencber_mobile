import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/product/product_response.dart';
import 'package:rencber_mobile/product/services/product/products.dart';

final productFutureProvider = FutureProvider<BaseResponseModel<List<ProductResponseModel>>>(
  (ref) async {
    var response = await ProductApiService.instance.get();
    return response;
  },
);
