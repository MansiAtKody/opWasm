// To parse this JSON data, do
//
//     final dispatchedOrderListResponseModel = dispatchedOrderListResponseModelFromJson(jsonString);

import 'dart:convert';

DispatchedOrderListResponseModel dispatchedOrderListResponseModelFromJson(String str) => DispatchedOrderListResponseModel.fromJson(json.decode(str));

String dispatchedOrderListResponseModelToJson(DispatchedOrderListResponseModel data) => json.encode(data.toJson());

class DispatchedOrderListResponseModel {
  String? message;
  List<TaskDetail>? data;
  int? status;

  DispatchedOrderListResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory DispatchedOrderListResponseModel.fromJson(Map<String, dynamic> json) => DispatchedOrderListResponseModel(
    message: json["message"],
    data: json["data"] == null ? [] : List<TaskDetail>.from(json["data"]!.map((x) => TaskDetail.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
  };
}

class TaskDetail {
  String? uuid;
  String? orderUuid;
  String? status;
  String? locationPointsUuid;
  String? locationPointsName;
  String? entityUuid;
  String? entityName;
  String? entityType;
  List<TaskItemResponseDto>? taskItemResponseDtOs;

  TaskDetail({
    this.uuid,
    this.orderUuid,
    this.status,
    this.locationPointsUuid,
    this.locationPointsName,
    this.entityUuid,
    this.entityName,
    this.entityType,
    this.taskItemResponseDtOs,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) => TaskDetail(
    uuid: json["uuid"],
    orderUuid: json["orderUuid"],
    status: json["status"],
    locationPointsUuid: json["locationPointsUuid"],
    locationPointsName: json["locationPointsName"],
    entityUuid: json["entityUuid"],
    entityName: json["entityName"],
    entityType: json["entityType"],
    taskItemResponseDtOs: json["taskItemResponseDTOs"] == null ? [] : List<TaskItemResponseDto>.from(json["taskItemResponseDTOs"]!.map((x) => TaskItemResponseDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "orderUuid": orderUuid,
    "status": status,
    "locationPointsUuid": locationPointsUuid,
    "locationPointsName": locationPointsName,
    "entityUuid": entityUuid,
    "entityName": entityName,
    "entityType": entityType,
    "taskItemResponseDTOs": taskItemResponseDtOs == null ? [] : List<dynamic>.from(taskItemResponseDtOs!.map((x) => x.toJson())),
  };
}

class TaskItemResponseDto {
  String? uuid;
  String? orderItemUuid;
  dynamic productUuid;
  String? productName;
  String? productDescription;
  String? productImage;
  int? trayNumber;

  TaskItemResponseDto({
    this.uuid,
    this.orderItemUuid,
    this.productUuid,
    this.productName,
    this.productDescription,
    this.productImage,
    this.trayNumber,
  });

  factory TaskItemResponseDto.fromJson(Map<String, dynamic> json) => TaskItemResponseDto(
    uuid: json["uuid"],
    orderItemUuid: json["orderItemUuid"],
    productUuid: json["productUuid"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    productImage: json["productImage"],
    trayNumber: json["trayNumber"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "orderItemUuid": orderItemUuid,
    "productUuid": productUuid,
    "productName": productName,
    "productDescription": productDescription,
    "productImage": productImage,
    "trayNumber": trayNumber,
  };
}
