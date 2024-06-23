import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/contract/user_management_repository.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/add_sub_operator_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/edit_sub_operator_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_details_response_model.dart';
import 'package:kody_operator/framework/repository/user_management/model/response_model/sub_operator_list_response_model.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';

@LazySingleton(as: UserManagementRepository, env: [Env.dev, Env.uat])
class UserManagementApiRepository extends UserManagementRepository{
  final DioClient apiClient;
  UserManagementApiRepository(this.apiClient);

  /// Operator List Api
  @override
  Future subOperatorListApi(int pageNumber,String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.subOperatorList(pageNumber),request);
      SubOperatorListResponseModel responseModel = subOperatorListResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Operator Dynamic Form Api
  @override
  Future subOperatorDynamicFormApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.addSubOperatorForm);
      DynamicFormResponseModel responseModel = dynamicFormResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Edit Operator Dynamic Form Api
  @override
  Future editSubOperatorDynamicFormApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.editSubOperatorForm);
      DynamicFormResponseModel responseModel = dynamicFormResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Add Sub Operator Api
  @override
  Future addSubOperatorApi(String request) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.addSubOperator,request);
      AddSubOperatorResponseModel responseModel = addSubOperatorResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Edit Sub Operator Api
  @override
  Future editSubOperatorApi(String request) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.addSubOperator,request);
      EditSubOperatorResponseModel responseModel = editSubOperatorResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Active/Deactivate Sub Operator Api
  @override
  Future activeDeactivateSubOperatorApi(String uuid, bool isActive) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.activeDeactivateSubOperator(uuid, isActive), '');
      CommonResponseModel responseModel = commonResponseModelFromJson(response.toString());
      return ApiResult.success(data: responseModel);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future subOperatorDetail(String uuid) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.subOperatorDetail(uuid));
      SubOperatorDetailResponseModel responseModel = subOperatorDetailResponseModelFromJson(response.toString());
      return ApiResult.success(data: responseModel);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
}