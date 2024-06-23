// To parse this JSON data, do
//
//     final locationPointListResponseModel = locationPointListResponseModelFromJson(jsonString);
import 'dart:convert';

LocationPointListResponseModel locationPointListResponseModelFromJson(String str) => LocationPointListResponseModel.fromJson(json.decode(str));

String locationPointListResponseModelToJson(LocationPointListResponseModel data) => json.encode(data.toJson());

class LocationPointListResponseModel {
  int? pageNumber;
  List<LocationPointResponseModel>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  int? pageSize;
  String? message;
  int? totalCount;
  int? status;

  LocationPointListResponseModel({
    this.pageNumber,
    this.data,
    this.hasNextPage,
    this.totalPages,
    this.hasPreviousPage,
    this.pageSize,
    this.message,
    this.totalCount,
    this.status,
  });

  factory LocationPointListResponseModel.fromJson(Map<String, dynamic> json) => LocationPointListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<LocationPointResponseModel>.from(json["data"]!.map((x) => LocationPointResponseModel.fromJson(x))),
    hasNextPage: json["hasNextPage"],
    totalPages: json["totalPages"],
    hasPreviousPage: json["hasPreviousPage"],
    pageSize: json["pageSize"],
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
    "pageSize": pageSize,
    "message": message,
    "totalCount": totalCount,
    "status": status,
  };
}

class LocationPointResponseModel {
  String? uuid;
  String? name;
  double? xaPoint;
  double? yaPoint;
  double? tethaPoint;
  String? fieldValue;
  String? locationUuid;
  String? locationName;
  bool? active;
  bool? isDefault;

  LocationPointResponseModel({
    this.uuid,
    this.name,
    this.xaPoint,
    this.yaPoint,
    this.tethaPoint,
    this.fieldValue,
    this.locationUuid,
    this.locationName,
    this.active,
    this.isDefault,
  });

  factory LocationPointResponseModel.fromJson(Map<String, dynamic> json) => LocationPointResponseModel(
    uuid: json["uuid"],
    name: json["name"],
    xaPoint: json["xaPoint"]?.toDouble(),
    yaPoint: json["yaPoint"]?.toDouble(),
    tethaPoint: json["tethaPoint"]?.toDouble(),
    fieldValue: json["fieldValue"],
    locationUuid: json["locationUuid"],
    locationName: json["locationName"],
    active: json["active"],
    isDefault: json["isDefault"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "xaPoint": xaPoint,
    "yaPoint": yaPoint,
    "tethaPoint": tethaPoint,
    "fieldValue": fieldValue,
    "locationUuid": locationUuid,
    "locationName": locationName,
    "active": active,
    "isDefault": isDefault,
  };
}
