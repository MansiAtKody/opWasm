import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';

abstract class DynamicFormRepository {


  Future<ApiResult> getDropdownValuesApi(String endpoint, String? request);

  ////-------------------- Operator ------------------------//////
  ///Add operator dynamic form
  Future<ApiResult<DynamicFormResponseModel>> addOperatorFormApi();

  ///Edit operator dynamic form
  Future<ApiResult<DynamicFormResponseModel>> editOperatorFormApi();

}
