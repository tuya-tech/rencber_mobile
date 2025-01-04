import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rencber_mobile/features/advice/view/advice.dart';
import 'package:rencber_mobile/product/models/advice/advice_response.dart';

mixin AdviceMixin on ConsumerState<AdviceView> {
  (List<AdviceResponseModel>, List<AdviceResponseModel>) outLineAndNormalData(List<AdviceResponseModel> data) {
    return (data.where((element) => element.brand == "Aydınlı").toList(), data.where((element) => element.brand != "Aydınlı").toList());
  }
}
