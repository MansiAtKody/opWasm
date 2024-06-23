import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/contract/robot_tray_selection_repository.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/get_tray_list_response_model.dart';
import 'package:kody_operator/framework/repository/robot_tray_selection/model/response_model/robot_list_response_model.dart';

@LazySingleton(as: RobotTraySelectionRepository, env: [Env.dev, Env.uat])
class RobotTraySelectionApiRepository extends RobotTraySelectionRepository{
  final DioClient apiClient;
  RobotTraySelectionApiRepository(this.apiClient);

  /// robot list Api
  @override
  Future robotListApi(String request, int pageNo) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.robotList(pageNo),request, noAuth: true);
      RobotListResponseModel responseModel = robotListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// add item to tray Api
  @override
  Future addItemToTrayApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.addItemToTray,request);
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

  /// delete item from tray Api
  @override
  Future deleteItemFromTrayApi(String uuid) async {
    try {
      Response? response = await apiClient.deleteRequest(ApiEndPoints.deleteItemFromTray(uuid), '');
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

  /// get tray list Api
  @override
  Future getTrayListApi(String robotUuid, int trayNumber) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.getTrayList(robotUuid, trayNumber));
      GetTrayListResponseModel responseModel = getTrayListResponseModelFromJson(response.toString());
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