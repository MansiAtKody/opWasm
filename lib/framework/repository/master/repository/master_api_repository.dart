import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kody_operator/framework/provider/network/api_end_points.dart';
import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/provider/network/dio/dio_client.dart';
import 'package:kody_operator/framework/provider/network/network_exceptions.dart';
import 'package:kody_operator/framework/repository/master/model/demo_response_model.dart';
import 'package:kody_operator/framework/repository/master/contract/master_repository.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

@LazySingleton(as: MasterRepository, env: [Env.dev, Env.uat])
class MasterApiRepository implements MasterRepository{
  final DioClient apiClient;
  MasterApiRepository(this.apiClient);

  ///demo Api
  @override
  Future demoApi(BuildContext context, Map<String, dynamic> request) async{
    try {
      Response? response = await apiClient.getRequest(ApiEndPoints.login);
      DemoResponseModel responseModel = demoResponseModelFromJson(response.toString());
      return ApiResult.success(data: responseModel);
    } catch (err) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(err));
    }
  }
}
