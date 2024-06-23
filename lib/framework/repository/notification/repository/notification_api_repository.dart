import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/notification/contract/notification_repository.dart';
import 'package:kody_operator/framework/dependency_injection/inject.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/notification/model/response%20model/notification_list_count_response_model.dart';
import 'package:kody_operator/framework/repository/notification/model/response%20model/notification_list_response_model.dart';

@LazySingleton(as: NotificationRepository, env: [Env.dev, Env.uat])
class NotificationApiRepository extends NotificationRepository {
  final DioClient apiClient;

  NotificationApiRepository(this.apiClient);

/*
  /// Login Api
  @override
  Future loginApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.login, request);
      LoginResponseModel responseModel = loginResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }*/

  @override
  Future notificationListAPI(int pageNumber)async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.notificationList(pageNumber));
      NotificationListResponseModel responseModel = notificationListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future deleteNotification(String notificationId) async{
    try {
      Response? response = await apiClient.deleteRequest(ApiEndPoints.notificationListDeleteNotification(notificationId), '');
      CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future deleteNotificationList() async{
    try {
      Response? response = await apiClient.deleteRequest(ApiEndPoints.notificationListDeleteAll, '');
      CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future notificationListCountAPI() async{
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.notificationListCount);
      NotificationListCountResponseModel responseModel = notificationListCountResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
}
