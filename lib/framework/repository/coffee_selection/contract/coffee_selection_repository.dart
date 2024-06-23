import 'package:kody_operator/framework/provider/network/api_result.dart';

abstract class CoffeeSelectionRepository {

  /// Select Program API
  Future<ApiResult> selectProgramAPI(String request);

  /// Select Program API
  Future<ApiResult> refreshTokenApi();

  /// Active Program API
  Future<ApiResult> activeProgramAPI(String request);

  /// Start Voltage API
  Future<ApiResult> startVoltageAPI();

  /// Stop Voltage API
  Future<ApiResult> stopVoltageAPI();

  /// Start Dasher API
  Future<ApiResult> startDasherAPI();

  ///Emergency Stop Api
  Future<ApiResult> emergencyStopAPI();

}
