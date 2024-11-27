import 'package:dio/dio.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class PhoneCodeApiService {
  PhoneCodeApiService._();
  static final instance = PhoneCodeApiService._();

  Future<BaseResponseModel<bool>> post(String code, int userId) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.valideCode,
        data: {"code": code, "userId": userId},
        options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<bool>(
          data: response.data,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<bool>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return DioManager.dioError<bool>(e);
    }
  }
}
