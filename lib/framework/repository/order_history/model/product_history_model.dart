
import 'package:kody_operator/framework/repository/order_management/model/order_detail_model.dart';

class ProductHistoryModel {
  /// Order detail info
  final String orderId;
  final String userName;
  final String department;
  final String date;
  final String order;
  final String customization;
  final String status;
  final List<OrderDetail> orderDetail;
  bool isCancel = true;


  ProductHistoryModel({
    required this.orderId,
    required this.userName,
    required this.department,
    required this.date,
    required this.order,
    required this.customization,
    required this.status,
    required this.orderDetail,
  });
}
