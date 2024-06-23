import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/cms/contract/cms_repository.dart';
import 'package:kody_operator/framework/repository/cms/model/cms_model.dart';


@LazySingleton(as: CMSRepository, env: [Env.dev, Env.uat])
class CMSApiRepository extends CMSRepository{
  final DioClient apiClient;
  CMSApiRepository(this.apiClient);

  /// CMS API
  @override
  Future getCmsApi(String cmsType) async{
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.cms(cmsType));
      CmsResponseModel responseModel = cmsResponseModelFromJson(response.toString());
      if (response?.statusCode == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
}