import 'package:kody_operator/framework/provider/network/api_result.dart';
import 'package:kody_operator/framework/repository/order_management/model/robot_details_response_model.dart';


abstract class OrderControlRepository {
  /// Update Whole order status api
  Future updateOrderStatus(String orderId, String status);

  /// Dispatch order
  Future dispatchOrderApi(String robotUuid);

  /// Update order item status api
  Future updateOrderItemStatusApi(String orderItemId, String status);


  /// Get Robot Details
  Future<ApiResult<RobotDetailsResponseModel>> getRobotDetails(String uuid);

  ///Register device FCM token
  Future registerDeviceApi(String request);

}
