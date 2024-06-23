// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:kody_operator/framework/provider/network/api_end_points.dart';
// import 'package:kody_operator/framework/provider/network/api_result.dart';
// import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
// import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
// import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
// import 'package:kody_operator/framework/repository/order_management/contract/order_management_repository.dart';
// import 'package:kody_operator/framework/repository/order_management/model/robot_details_response_model.dart';
//
// @LazySingleton(as: OrderManagementRepository, env: ['debug', 'production'])
// class OrderManagementApiRepository implements OrderManagementRepository {
//   DioClient apiClient;
//
//   OrderManagementApiRepository(this.apiClient);
//
//   /// Update order status api
//   @override
//   Future updateOrderStatus(String orderId, String status) async {
//     try {
//       Response? response = await apiClient.putRequest(ApiEndPoints.updateOrderStatus(orderId, status), '');
//       CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
//       if (responseModel.status == ApiEndPoints.apiStatus_200) {
//         return ApiResult.success(data: responseModel);
//       } else {
//         return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
//       }
//     } catch (err) {
//       return ApiResult.failure(error: NetworkExceptions.getDioException(err));
//     }
//   }
//
//   /// Update order item status api
//   @override
//   Future updateOrderItemStatusApi(String orderItemId, String status) async {
//     try {
//       Response? response = await apiClient.putRequest(ApiEndPoints.updateOrderItemStatus(orderItemId, status), '');
//       CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
//       if (responseModel.status == ApiEndPoints.apiStatus_200) {
//         return ApiResult.success(data: responseModel);
//       } else {
//         return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
//       }
//     } catch (err) {
//       return ApiResult.failure(error: NetworkExceptions.getDioException(err));
//     }
//   }
//
//   /// Dispatch Order Api
//   @override
//   Future dispatchOrderApi(String request) async {
//     try {
//       Response? response = await apiClient.putRequest(ApiEndPoints.dispatchOrder, request);
//       CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
//       if (responseModel.status == ApiEndPoints.apiStatus_200) {
//         return ApiResult.success(data: responseModel);
//       } else {
//         return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
//       }
//     } catch (err) {
//       return ApiResult.failure(error: NetworkExceptions.getDioException(err));
//     }
//   }
//
//   @override
//   Future refreshSocket() async {
//     try {
//       await apiClient.getRequest(ApiEndPoints.refreshSocket);
//       return const ApiResult.success(data: true);
//     } catch (err) {
//       return ApiResult.failure(error: NetworkExceptions.getDioException(err));
//     }
//   }
//
//   @override
//   Future<ApiResult<RobotDetailsResponseModel>> getRobotDetails(String uuid) async {
//     try {
//       Response? response = await apiClient.getRequest(ApiEndPoints.getRobotDetails(uuid));
//       RobotDetailsResponseModel responseModel = robotDetailsResponseModelFromJson(response.toString());
//       if (responseModel.status == ApiEndPoints.apiStatus_200) {
//         return ApiResult.success(data: responseModel);
//       } else {
//         return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
//       }
//     } catch (err) {
//       return ApiResult.failure(error: NetworkExceptions.getDioException(err));
//     }
//   }
// }