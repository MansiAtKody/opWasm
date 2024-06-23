import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/cart/contract/cart_repository.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_count_response_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_detail_reponse_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/cart_list_response_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/frequenlty_bought_list_response_model.dart';
import 'package:kody_operator/framework/repository/cart/model/response_model/validate_item_response_model.dart';

@LazySingleton(as: CartRepository, env: [Env.dev, Env.uat])
class CartApiRepository extends CartRepository{
  final DioClient apiClient;
  CartApiRepository(this.apiClient);

  @override
  Future cartCountApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.cartCount);
      CartCountResponseModel responseModel = cartCountResponseModelFromJson(response.toString());
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
  Future cartListApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.cartList);
      CartListResponseModel responseModel = cartListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Cart Qty
  @override
  Future updateCartQtyApi(String request,String productUuid,int qty) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.updateCartQty(productUuid, qty),request);
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


  ///Cart Detail Api
  @override
  Future cartDetailApi(String productUuid) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.cartDetail(productUuid));
      CartDetailResponseModel responseModel = cartDetailResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }


  ///Add Items in cart
  @override
  Future addCartApi(String request) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.addCartItem,request);
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

  ///Validate Items in cart
  @override
  Future validateItemApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.validateItem,request);
      ValidateItemResponseModel responseModel = validateItemResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Add item list in cart
  @override
  Future addItemListCartApi(String request) async{
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.addItemListCart,request);
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
  Future frequentlyBoughtListApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.frequentlyBoughtList);
      FrequentlyBoughtListResponseModel responseModel = frequentlyBoughtListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Clear cart api
  @override
  Future clearCartApi() async{
    try {
      Response? response = await apiClient.deleteRequest(ApiEndPoints.clearCart,'');
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

}