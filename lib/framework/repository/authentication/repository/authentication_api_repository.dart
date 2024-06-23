import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/contract/authentication_repository.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/login_response_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/response%20model/send_otp_response_model.dart';

@LazySingleton(as: AuthenticationRepository, env: [Env.dev, Env.uat])
class AuthenticationApiRepository extends AuthenticationRepository{
  final DioClient apiClient;
  AuthenticationApiRepository(this.apiClient);

  /// Login Api
  @override
  Future loginApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.login,request);
      LoginResponseModel responseModel = loginResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// forgotPasswordApi
  @override
  Future forgotPasswordApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.forgotPassword,request);
      CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// verifyOtpApi
  @override
  Future verifyOtpApi(String request) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.verifyOtp,request);
      CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// resetPasswordApi
  @override
  Future resetPasswordApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.resetPassword,request);
      CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
  /// resendOtpApi
  @override
  Future resendOtpApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.resendOtp,request);
      SendOtpResponseModel responseModel = sendOtpResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// deleteEmployeeApi
  @override
  Future deleteOperatorApi(String uuid) async {
    try {
      Response? response = await apiClient.deleteRequest(ApiEndPoints.deleteOperator(uuid), '');
      CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future deleteDeviceTokenApi(String deviceId) async{
    try {
      Response? response = await apiClient.deleteRequest(ApiEndPoints.deleteDeviceToken(deviceId), '');
      CommonResponseModel responseModel =  commonResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

}