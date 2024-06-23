
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/authentication/model/common_response_model.dart';
import 'package:kody_operator/framework/repository/profile/contract/profile_repository.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/change_password_response_model.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/profile_detail_response_model.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/update_email_response_model.dart';
import 'package:kody_operator/framework/repository/profile/model/response_model/update_profile_image_response_model.dart';

@LazySingleton(as: ProfileRepository, env: [Env.dev, Env.uat])
class ProfileApiRepository extends ProfileRepository{
  final DioClient apiClient;
  ProfileApiRepository(this.apiClient);

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


  @override
  Future changePassword(String request) async {
    try {
      Response? response = await apiClient.putRequest(ApiEndPoints.changePassword,request);
      ChangePasswordResponseModel responseModel = changePasswordResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  ///Profile Image api
  @override
  Future updateProfileImageApi(FormData request,String uuid) async {
    try {
      Response? response = await apiClient.putRequestFormData(ApiEndPoints.uploadProfileImage(uuid),request);
      print('Response: $response');
      UpdateProfileImageResponseModel responseModel = updateProfileImageResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Update the mobile no and the email
  @override
  Future updateEmailMobile(String request,bool isEmail) async{
    try {
      Response? response = await apiClient.putRequest(isEmail?ApiEndPoints.updateEmail:ApiEndPoints.updateContact,request);
      UpdateEmailResponseModel responseModel = updateEmailResponseModelFromJson(response.toString());
      if (responseModel.status == ApiEndPoints.apiStatus_200) {
        return ApiResult.success(data: responseModel);
      } else {
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  /// Check Password API
  @override
  Future checkPassword(String request) async{
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.checkPassword,request);
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