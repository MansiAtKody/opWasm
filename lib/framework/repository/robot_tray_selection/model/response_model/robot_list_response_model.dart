// To parse this JSON data, do
//
//     final robotListResponseModel = robotListResponseModelFromJson(jsonString);

import 'dart:convert';

RobotListResponseModel robotListResponseModelFromJson(String str) => RobotListResponseModel.fromJson(json.decode(str));

String robotListResponseModelToJson(RobotListResponseModel data) => json.encode(data.toJson());

class RobotListResponseModel {
  int? pageNumber;
  List<RobotListResponseData>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  String? message;
  int? totalCount;
  int? status;

  RobotListResponseModel({
    this.pageNumber,
    this.data,
    this.hasNextPage,
    this.totalPages,
    this.hasPreviousPage,
    this.message,
    this.totalCount,
    this.status,
  });

  factory RobotListResponseModel.fromJson(Map<String, dynamic> json) => RobotListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<RobotListResponseData>.from(json["data"]!.map((x) => RobotListResponseData.fromJson(x))),
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

class RobotListResponseData {
  String? uuid;
  String? name;
  String? robotCode;
  int? numberOfTray;
  String? state;
  String? operatorUuid;
  String? operatorName;
  bool? active;
  int? entityId;

  RobotListResponseData({
    this.uuid,
    this.name,
    this.robotCode,
    this.numberOfTray,
    this.state,
    this.operatorUuid,
    this.operatorName,
    this.active,
    this.entityId,
  });

  factory RobotListResponseData.fromJson(Map<String, dynamic> json) => RobotListResponseData(
    uuid: json["uuid"],
    name: json["name"],
    robotCode: json["robotCode"],
    numberOfTray: json["numberOfTray"],
    state: json["state"],
    operatorUuid: json["operatorUuid"],
    operatorName: json["operatorName"],
    active: json["active"],
    entityId: json["entityId"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "robotCode": robotCode,
    "numberOfTray": numberOfTray,
    "state": state,
    "operatorUuid": operatorUuid,
    "operatorName": operatorName,
    "active": active,
    "entityId": entityId,
  };
}
