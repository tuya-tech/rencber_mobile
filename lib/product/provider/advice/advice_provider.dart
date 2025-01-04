import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/services/advice/advice.dart';

final adviceFutureProvider = FutureProvider.autoDispose<BaseResponseModel<List<AdviceResponseModel>>>(
  (ref) async {
    return AdviceApiService.instance.get();
  },
);

final adviceIdFutureProvider = FutureProvider.autoDispose.family<BaseResponseModel<AdviceResponseModel>, int>(
  (ref, id) async {
    return AdviceApiService.instance.getById(id);
  },
);
