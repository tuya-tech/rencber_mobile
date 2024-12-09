import 'package:dio/dio.dart';
import 'package:rencber_mobile/product/models/base_response.dart';
import 'package:rencber_mobile/product/models/user/user_request.dart';
import 'package:rencber_mobile/product/models/user/user_response.dart';
import 'package:rencber_mobile/product/services/_dio_manager/dio_mixin.dart';
import 'package:rencber_mobile/product/services/_dio_manager/services_path.dart';

class UserApiService {
  UserApiService._();
  static final instance = UserApiService._();

  Future<BaseResponseModel<UserResponseModel>> getById(int id) async {
    try {
      final response = await DioManager.dio.get(
        "${ServicesPath.instance.user}/$id",
        options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<UserResponseModel>(
          data: UserResponseModel.fromJson(response.data),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<UserResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return DioManager.dioError<UserResponseModel>(e);
    }
  }

  Future<BaseResponseModel<UserResponseModel>> post(UserRequestModel userData) async {
    try {
      final response = await DioManager.dio.put(
        ServicesPath.instance.user,
        data: userData,
        options: await DioManager.getOptions(),
      );

      if (response.statusCode == 200) {
        return BaseResponseModel<UserResponseModel>(
          data: UserResponseModel.fromJson(response.data),
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      } else {
        return BaseResponseModel<UserResponseModel>(
          data: null,
          message: response.statusMessage,
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      return DioManager.dioError<UserResponseModel>(e);
    }
  }
}
