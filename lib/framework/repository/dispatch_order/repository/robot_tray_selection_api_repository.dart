import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/dispatch_order/contract/dispatched_order_repository.dart';
import 'package:kody_operator/framework/repository/dispatch_order/model/response_model/dispatched_order_list_response_model.dart';

@LazySingleton(as: DispatchedOrderRepository, env: [Env.dev, Env.uat])
class DispatchedOrderApiRepository extends DispatchedOrderRepository{
  final DioClient apiClient;
  DispatchedOrderApiRepository(this.apiClient);


  /// get tray list Api
  @override
  Future changeOrderStatus(String taskUuid, String status) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.changeOrderStatus(taskUuid, status),'');
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


  /// get dispatched order list
  @override
  Future getDispatchedOrderList(String robotUuid) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.getDispatchedOrderList(robotUuid));
      DispatchedOrderListResponseModel responseModel = dispatchedOrderListResponseModelFromJson(response.toString());
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