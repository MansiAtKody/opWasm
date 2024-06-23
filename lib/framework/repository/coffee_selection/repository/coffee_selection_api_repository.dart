import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/authentication/model/start_program_response_model.dart';
import 'package:kody_operator/framework/repository/coffee_selection/contract/coffee_selection_repository.dart';
import 'package:kody_operator/framework/repository/coffee_selection/model/refresh_token_response_model.dart';

@LazySingleton(as: CoffeeSelectionRepository, env: [Env.dev, Env.uat])
class CoffeeSelectionApiRepository implements CoffeeSelectionRepository {
  final DioClient apiClient;

  CoffeeSelectionApiRepository(this.apiClient);

  ///Select Program Api
  @override
  Future<ApiResult> selectProgramAPI(String request) async {
    try {
      Response? responseModel = await apiClient.putRequestSDKApis(ApiEndPoints.selectProgramAPI, request);
      CommonResponseModel? commonResponseModel = CommonResponseModel(status: responseModel?.statusCode == 204 ? 200 : responseModel?.statusCode, message: responseModel?.statusMessage);

      if (commonResponseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: commonResponseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel?.statusMessage ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Refresh Token
  @override
  Future<ApiResult> refreshTokenApi() async {
    try {
      Response? responseModel = await apiClient.refreshToken();
      RefreshTokenResponseModel? commonResponseModel = refreshTokenResponseModelFromJson(responseModel.toString());
      return ApiResult.success(data: commonResponseModel);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Active Program Api
  @override
  Future<ApiResult> activeProgramAPI(String request) async {
    try {
      Response? responseModel = await apiClient.putRequestSDKApis(ApiEndPoints.activateProgramAPI, request);
      CommonResponseModel? commonResponseModel = CommonResponseModel(status: responseModel?.statusCode == 204 ? 200 : responseModel?.statusCode, message: responseModel?.statusMessage);

      if (commonResponseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: commonResponseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel?.statusMessage ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Start Voltage Api
  @override
  Future<ApiResult> startVoltageAPI() async {
    try {
      Response? responseModel = await apiClient.roboticArmApi(ApiEndPoints.startVoltageAPI);
      //StartProgramResponseModel? startProgramResponseModel = startProgramResponseModelFromJson(jsonDecode(responseModel?.data.toString() ?? ''));
      StartProgramResponseModel? startProgramResponseModel = startProgramResponseModelFromJson(responseModel.toString());

      if (startProgramResponseModel.status == 'success') {
        return ApiResult.success(data: startProgramResponseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel?.statusMessage ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Stop Voltage Api
  @override
  Future<ApiResult> stopVoltageAPI() async {
    try {
      Response? responseModel = await apiClient.roboticArmApi(ApiEndPoints.stopVoltageAPI);
      StartProgramResponseModel? startProgramResponseModel = startProgramResponseModelFromJson(responseModel?.data.toString() ?? '');

      if (startProgramResponseModel.status == 'success') {
        return ApiResult.success(data: startProgramResponseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel?.statusMessage ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Start Dasher Api
  @override
  Future<ApiResult> startDasherAPI() async {
    try {
      Response? responseModel = await apiClient.roboticArmApi(ApiEndPoints.startDasher);
      StartProgramResponseModel? startProgramResponseModel = startProgramResponseModelFromJson(responseModel?.data.toString() ?? '');

      if (startProgramResponseModel.status == 'success') {
        return ApiResult.success(data: startProgramResponseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel?.statusMessage ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Emergency Stop Api
  @override
  Future<ApiResult> emergencyStopAPI() async {
    try {
      Response? responseModel = await apiClient.roboticArmApi(ApiEndPoints.emergencyStop);
      StartProgramResponseModel? startProgramResponseModel = startProgramResponseModelFromJson(responseModel?.data.toString() ?? '');

      if (startProgramResponseModel.status == 'success') {
        return ApiResult.success(data: startProgramResponseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel?.statusMessage ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
}
