import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/order_history/contract/order_history_repository.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_detail_response_model.dart';
import 'package:kody_operator/framework/repository/order_history/model/response/order_list_response_model.dart';

@LazySingleton(as: OrderHistoryRepository, env: [Env.dev, Env.uat])
class OrderHistoryApiRepository implements OrderHistoryRepository {
  DioClient apiClient;

  OrderHistoryApiRepository(this.apiClient);

  ///Order List api
  @override
  Future getOrderListApi(String request, int pageNumber) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.getOrderList(pageNumber), request);
      OrderListResponseModel responseModel = orderListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Order Detail api
  @override
  Future getOrderDetailApi(String orderId) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.orderDetails(orderId));
      OrderDetailResponseModel responseModel = orderDetailResponseModelFromJson(response.toString());
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
