import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/product_management/contract/product_management_repository.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_category_list_response_model.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/get_product_list_response_model.dart';
import 'package:kody_operator/framework/repository/product_management/model/response_model/product_detail_reponse_model.dart';

@LazySingleton(as: ProductManagementRepository, env: [Env.dev, Env.uat])
class ProductManagementApiRepository extends ProductManagementRepository{
  final DioClient apiClient;
  ProductManagementApiRepository(this.apiClient);

  /// get category list Api
  @override
  Future getCategoryListApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.categoryList(isActive: true));
      GetCategoryListResponseModel responseModel = getCategoryListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// get product list Api
  @override
  Future getProductListApi(String request, int pageNo) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.getProductList(pageNo),request);
      GetProductListResponseModel responseModel = getProductListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Product Detail Api
  @override
  Future productDetailApi(String productUuid) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.productDetail(productUuid));
      ProductDetailResponseModel responseModel = productDetailResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Update Product Status Api
  @override
  Future updateProductStatusApi(String productUuid, bool active) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.updateProductStatus(productUuid, active), '');
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

  /// Update Product Attribute Status Api
  @override
  Future updateProductAttributeStatusApi(String attributeUuid, bool active) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.updateProductAttributeStatus(attributeUuid, active), '');
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

  /// Update Product Attribute Name Status Api
  @override
  Future updateProductAttributeNameStatusApi(String attributeNameUuid, bool active) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.updateProductAttributeNameStatus(attributeNameUuid, active), '');
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