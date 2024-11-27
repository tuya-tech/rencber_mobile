import 'package:dio/dio.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/register/register_request.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class RegisterApiService {
  RegisterApiService._();
  static final instance = RegisterApiService._();

  Future<BaseResponseModel<RegisterRequestModel>> post(RegisterRequestModel userData) async {
    try {
      final response = await DioManager.dio.post(
        ServicesPath.instance.register,
        data: userData,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<RegisterRequestModel>(
          data: RegisterRequestModel.fromJson(response.data),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<RegisterRequestModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return DioManager.dioError<RegisterRequestModel>(e);
    }
  }
}
