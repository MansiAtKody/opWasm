// To parse this JSON data, do
//
//     final orderListResponseModel = orderListResponseModelFromJson(jsonString);

import 'dart:convert';

OrderListResponseModel orderListResponseModelFromJson(String str) => OrderListResponseModel.fromJson(json.decode(str));

String orderListResponseModelToJson(OrderListResponseModel data) => json.encode(data.toJson());

class OrderListResponseModel {
  int? pageNumber;
  List<OrderData>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  String? message;
  int? totalCount;
  int? status;

  OrderListResponseModel({
    this.pageNumber,
    this.data,
    this.hasNextPage,
    this.totalPages,
    this.hasPreviousPage,
    this.message,
    this.totalCount,
    this.status,
  });

  factory OrderListResponseModel.fromJson(Map<String, dynamic> json) => OrderListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<OrderData>.from(json["data"]!.map((x) => OrderData.fromJson(x))),
    hasNextPage: json["hasNextPage"],
    totalPages: json["totalPages"],
    hasPreviousPage: json["hasPreviousPage"],
    message: json["message"],
    totalCount: json["totalCount"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "hasNextPage": hasNextPage,
    "totalPages": totalPages,
    "hasPreviousPage": hasPreviousPage,
    "message": message,
    "totalCount": totalCount,
    "status": status,
  };
}

class OrderData {
  String? uuid;
  int? createdAt;
  int? totalQty;
  String? status;
  String? entityUuid;
  String? entityName;
  String? entityType;
  dynamic totalPrice;
  String? locationUuid;
  String? locationName;
  String? locationPointsUuid;
  String? locationPointsName;

  OrderData({
    this.uuid,
    this.createdAt,
    this.totalQty,
    this.status,
    this.entityUuid,
    this.entityName,
    this.entityType,
    this.totalPrice,
    this.locationUuid,
    this.locationName,
    this.locationPointsUuid,
    this.locationPointsName,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    uuid: json["uuid"],
    createdAt: json["createdAt"],
    totalQty: json["totalQty"],
    status: json["status"],
    entityUuid: json["entityUuid"],
    entityName: json["entityName"],
    entityType: json["entityType"],
    totalPrice: json["totalPrice"],
    locationUuid: json["locationUuid"],
    locationName: json["locationName"],
    locationPointsUuid: json["locationPointsUuid"],
    locationPointsName: json["locationPointsName"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "createdAt": createdAt,
    "totalQty": totalQty,
    "status": status,
    "entityUuid": entityUuid,
    "entityName": entityName,
    "entityType": entityType,
    "totalPrice": totalPrice,
    "locationUuid": locationUuid,
    "locationName": locationName,
    "locationPointsUuid": locationPointsUuid,
    "locationPointsName": locationPointsName,
  };
}
