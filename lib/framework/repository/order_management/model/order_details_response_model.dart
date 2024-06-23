// To parse this JSON data, do
//
//     final orderDetailsResponseModel = orderDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsResponseModel orderDetailsResponseModelFromJson(String str) =>
    OrderDetailsResponseModel.fromJson(json.decode(str));

String orderDetailsResponseModelToJson(OrderDetailsResponseModel data) =>
    json.encode(data.toJson());

class OrderDetailsResponseModel {
  String userId;
  String userOrder;
  String userOrderDescription;
  String userName;
  String userRole;

  OrderDetailsResponseModel({
    required this.userId,
    required this.userOrder,
    required this.userOrderDescription,
    required this.userName,
    required this.userRole,
  });

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsResponseModel(
        userId: json["user_id"],
        userOrder: json["user_order"],
        userOrderDescription: json["user_order_description"],
        userName: json["user_name"],
        userRole: json["user_role"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_order": userOrder,
        "user_order_description": userOrderDescription,
        "user_name": userName,
        "user_role": userRole,
      };
}
