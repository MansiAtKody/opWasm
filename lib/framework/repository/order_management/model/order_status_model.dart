import 'package:kody_operator/framework/repository/order_management/model/order_detail_model.dart';

class OrderStatus {
  final int? userId;
  final String? userName;
  final String? placeName;
  final String? ticketNumber;
  final bool? isAccepted;
  List<OrderDetail> orderDetail = [];

  OrderStatus({
    this.userId,
    this.userName,
    this.placeName,
    this.ticketNumber,
    this.isAccepted = true,
    required this.orderDetail,
  });
}
