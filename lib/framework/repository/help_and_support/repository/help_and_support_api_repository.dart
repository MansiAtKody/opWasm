import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/help_and_support/contract/help_and_support_repository.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/add_ticket_response_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/get_ticket_list_response_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/ticket_details_response_model.dart';
import 'package:kody_operator/framework/repository/help_and_support/model/ticket_reason_list_response_model.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';


@LazySingleton(as: HelpAndSupportRepository, env: [Env.dev, Env.uat])
class HelpAndSupportApiRepository implements HelpAndSupportRepository{
  final DioClient apiClient;
  HelpAndSupportApiRepository(this.apiClient);

  ///demo Api
  @override
  Future<ApiResult> getTicketList({required String request, required int pageNo,int? pageSize}) async{
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.ticketList(pageNo), request);
      GetTicketListResponseModel responseModel = getTicketListResponseModelFromJson(response.toString());
      if(responseModel.status == ApiEndPoints.apiStatus_200){
        return ApiResult.success(data: responseModel);

      }else{
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future<ApiResult> getReasonsList({int? pageNo, int? pageSize, bool? activeRecords}) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.ticketReasonList(pageNo: pageNo,activeRecords: true));
      TicketReasonListResponseModel responseModel = ticketReasonListResponseModelFromJson(response.toString());
      if(responseModel.status == ApiEndPoints.apiStatus_200){
        return ApiResult.success(data: responseModel);
      }else{
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future<ApiResult> addTicketApi({required String request}) async {
    try {
      Response? response = await apiClient.postRequest(ApiEndPoints.addTicket,request);
      AddTicketResponseModel responseModel = addTicketResponseModelFromJson(response.toString());
      if(responseModel.status == ApiEndPoints.apiStatus_200){
        return ApiResult.success(data: responseModel);
      }else{
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }

  @override
  Future<ApiResult> getTicketDetails({required String uuid}) async {
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.ticketDetails(uuid));
      TicketDetailsResponseModel responseModel = ticketDetailsResponseModelFromJson(response.toString());
      if(responseModel.status == ApiEndPoints.apiStatus_200){
        return ApiResult.success(data: responseModel);
      }else{
        return ApiResult.failure(error: NetworkExceptions.defaultError(responseModel.message??''));
      }
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
}
