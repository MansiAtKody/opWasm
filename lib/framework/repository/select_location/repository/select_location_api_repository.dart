import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/profile_detail_response_model.dart';
import 'package:kody_operator/framework/repository/select_location/contract/select_location_repository.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_list_response_model.dart';
import 'package:kody_operator/framework/repository/select_location/model/location_point_list_response_model.dart';

@LazySingleton(as: SelectLocationRepository, env: [Env.dev, Env.uat])
class SelectLocationApiRepository implements SelectLocationRepository{
  final DioClient apiClient;
  SelectLocationApiRepository(this.apiClient);

  ///demo Api
  @override
  Future getLocationListApi({required int pageNumber}) async{
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.getLocationList(true, pageNumber));
      LocationListResponseModel responseModel = locationListResponseModelFromJson(response.toString());
      if(responseModel.status == ApiEndPoints.apiStatus_200){
        return ApiResult.success(data: responseModel);
      }else{
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future getLocationPointListApi({required String request, required int pageNumber}) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.getLocationPointList(true,pageNumber), request);
      LocationPointListResponseModel responseModel = locationPointListResponseModelFromJson(response.toString());
      if(responseModel.status == ApiEndPoints.apiStatus_200){
        return ApiResult.success(data: responseModel);
      }else{
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message ?? ''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future getProfileDetail() async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.profileDetail);
      ProfileDetailResponseModel responseModel = profileDetailResponseModelFromJson(response.toString());
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
