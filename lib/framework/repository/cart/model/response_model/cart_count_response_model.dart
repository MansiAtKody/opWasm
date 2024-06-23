// To parse this JSON data, do
//
//     final cartCountResponseModel = cartCountResponseModelFromJson(jsonString);

import 'dart:convert';

CartCountResponseModel cartCountResponseModelFromJson(String str) => CartCountResponseModel.fromJson(json.decode(str));

String cartCountResponseModelToJson(CartCountResponseModel data) => json.encode(data.toJson());

class CartCountResponseModel {
  String? message;
  int? data;
  int? status;

  CartCountResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory CartCountResponseModel.fromJson(Map<String, dynamic> json) => CartCountResponseModel(
    message: json['message'],
    data: json['data'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data,
    'status': status,
  };
}
