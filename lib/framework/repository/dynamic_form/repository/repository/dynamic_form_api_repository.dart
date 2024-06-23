import 'dart:convert';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/contract/dynamic_form_repository.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_drop_down_response_model.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DynamicFormRepository, env: [Env.dev, Env.uat])
class DynamicFormApiRepository implements DynamicFormRepository {
  final DioClient apiClient;

  DynamicFormApiRepository(this.apiClient);

  @override
  Future<ApiResult> getDropdownValuesApi(String endpoint, String? request, {String? method}) async {
    try {
      Response? response;
      if (request == null && method == 'GET') {
        response = await apiClient.getRequest(endpoint);
      } else {
        response = await apiClient.postRequest(endpoint, request ?? jsonEncode({}));
      }
      DynamicDropDownResponseModel responseModel = DynamicDropDownResponseModel.fromJson(jsonDecode(response.toString()));
      return ApiResult.success(data: responseModel);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  Future<ApiResult<DynamicFormResponseModel>> updateDropdownValues(DynamicFormResponseModel responseModel) async {
    if (responseModel.status == ApiEndPoints.apiStatus_200) {
      for (Field field in (responseModel.data?.fields ?? [])) {
        if ((dynamicWidgetsValueNew.map[field.type] == DynamicFormWidgetsEnumNew.dropdown) && (field.url != null)) {
          await getDropdownValuesApi((field.url ?? ''), null, method: field.urlMethod ?? 'GET').then((ApiResult value) {
            value.when(
              success: (success) {
                DynamicDropDownResponseModel responseModel = success as DynamicDropDownResponseModel;
                field.possibleValues = responseModel.data;
                if (field.parentFieldName != null) {
                  field.isEnabled = false;
                }
              },
              failure: (failure) {},
            );
          });
        }
      }
      return ApiResult.success(data: responseModel);
    } else {
      return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
    }
  }

  ////-----------------------Employee------------------------------////
  ///Add Operator Json Form Api
  @override
  Future<ApiResult<DynamicFormResponseModel>> addOperatorFormApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.addSubOperatorForm);
      DynamicFormResponseModel responseModel = dynamicFormResponseModelFromJson(response.toString());
      return await updateDropdownValues(responseModel);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Edit Operator Json Form Api
  @override
  Future<ApiResult<DynamicFormResponseModel>> editOperatorFormApi() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.editSubOperatorForm);
      DynamicFormResponseModel responseModel = dynamicFormResponseModelFromJson(response.toString());
      return await updateDropdownValues(responseModel);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
}
