import 'package:flutter/material.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';


///Model Class for Orders
class OrderModel {
  int? orderId;
  List<OrderItem>? itemList;
  OrderStatusEnum? status;
  OrderType? orderType;
  bool isFav;

  OrderModel({
    this.orderId,
    this.orderType,
    this.itemList,
    this.status,
    this.isFav = false,
  });
}

///Model Class For individual Items in order
class OrderItem {
  String? itemImage;
  String? itemName;
  String? description;

  OrderItem({
    this.itemImage,
    this.itemName,
    this.description,
  });
}

class OrderStyle {
  String orderStatus;
  Color buttonTextColor;
  Color buttonBgColor;

  OrderStyle({
    required this.orderStatus,
    required this.buttonTextColor,
    required this.buttonBgColor,
  });
}
