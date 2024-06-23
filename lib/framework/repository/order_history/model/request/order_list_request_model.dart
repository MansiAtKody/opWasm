// To parse this JSON data, do
//
//     final orderListRequestModel = orderListRequestModelFromJson(jsonString);

import 'dart:convert';

OrderListRequestModel orderListRequestModelFromJson(String str) => OrderListRequestModel.fromJson(json.decode(str));

String orderListRequestModelToJson(OrderListRequestModel data) => json.encode(data.toJson());

class OrderListRequestModel {
  String? searchKeyword;
  List<String>? status;
  List<String>? entityType;
  String? fromDate;
  String? toDate;

  OrderListRequestModel({
    this.searchKeyword,
    this.status,
    this.entityType,
    this.fromDate,
    this.toDate,
  });

  factory OrderListRequestModel.fromJson(Map<String, dynamic> json) => OrderListRequestModel(
    searchKeyword: json["searchKeyword"],
    status: json["status"] == null ? [] : List<String>.from(json["status"]!.map((x) => x)),
    entityType: json["entityType"] == null ? [] : List<String>.from(json["entityType"]!.map((x) => x)),
    fromDate: json["fromDate"],
    toDate: json["toDate"],
  );

  Map<String, dynamic> toJson() => {
    "searchKeyword": searchKeyword,
    "status": status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
    "entityType": entityType == null ? [] : List<dynamic>.from(entityType!.map((x) => x)),
    "fromDate": fromDate,
    "toDate": toDate,
  };
}
