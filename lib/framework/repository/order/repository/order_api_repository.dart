import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/order/contract/order_repository.dart';
import 'package:kody_operator/framework/repository/order/model/response/category_list_response_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_details_response_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/order_list_response_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_detail_response_model.dart';
import 'package:kody_operator/framework/repository/order/model/response/product_list_reponse_model.dart';

@LazySingleton(as: OrderRepository, env: [Env.dev, Env.uat])
class OrderApiRepository implements OrderRepository {
  DioClient apiClient;

  OrderApiRepository(this.apiClient);

  ///Product List
  @override
  Future getProductListApi(String request) async{
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.productList,request);
      ProductListResponseModel responseModel =  productListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
  ///Get Category List Api
  @override
  Future categoryListApi({int? pageSize, bool? isActive}) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.categoryList(pageSizeInternal: pageSize, isActive: isActive));
      CategoryListResponseModel responseModel = categoryListResponseModelFromJson(response.toString());
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
  Future productDetailApi(String productUuid) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.getProductDetails(productUuid));
      ProductDetailResponseModel responseModel = productDetailResponseModelFromJson(response.toString());
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
  Future placeOrderApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.placeOrder, request);
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
  Future orderListApi(String request,{int? pageNumber}) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.orderList(pageNumber??1), request);
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

  @override
  Future cancelOrderApi(String orderUuid) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.cancelOrder(orderUuid), '');
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

  /// Update order status api
  @override
  Future updateOrderStatusApi(String orderId, String status) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.updateOrderStatus(orderId, status), '');
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


  /// Update order item status api
  @override
  Future updateOrderItemStatusApi(String orderItemId, String status) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.updateOrderItemStatus(orderItemId, status), '');
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
  Future orderDetailsApi(String orderUuid) async {
    try {
      Response? response = await apiClient.getRequest(
        ApiEndPoints.orderDetails(orderUuid),
      );
      OrderDetailsResponseModel responseModel = orderDetailsResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
  ///Update Order Location Points
  @override
  Future changeOrderLocationPointsApi(String orderUuid, String locationPointsUuid) async{
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.changeOrderLocationPoints(orderUuid, locationPointsUuid), '');
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
  Future refreshSocket(String queueName) async {
    try {
      await apiClient.getRequest(ApiEndPoints.refreshSocket(queueName));
      return const ApiResult.success(data: true);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future favouriteOrderApi(String orderUUid,bool isFavourite) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.favouriteOrderStatus(orderUUid, isFavourite),'');
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


}
