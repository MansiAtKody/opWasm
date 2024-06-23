import 'package:kody_operator/framework/repository/order_management/model/order_details_response_model.dart';

class TrayModel {
  String trayId;
  OrderDetailsResponseModel? orderDetails;

  TrayModel({
    required this.trayId,
    this.orderDetails,
  });
}