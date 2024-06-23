// To parse this JSON data, do
//
// final locationListResponseModel = locationListResponseModelFromJson(jsonString);

import 'dart:convert';

LocationListResponseModel locationListResponseModelFromJson(String str) => LocationListResponseModel.fromJson(json.decode(str));

String locationListResponseModelToJson(LocationListResponseModel data) => json.encode(data.toJson());

class LocationListResponseModel {
  int? pageNumber;
  List<LocationResponseModel>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  int? pageSize;
  String? message;
  int? totalCount;
  int? status;

  LocationListResponseModel({
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

  factory LocationListResponseModel.fromJson(Map<String, dynamic> json) => LocationListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<LocationResponseModel>.from(json["data"]!.map((x) => LocationResponseModel.fromJson(x))),
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

class LocationResponseModel {
  String? uuid;
  String? name;
  bool? active;

  LocationResponseModel({
    this.uuid,
    this.name,
    this.active,
  });

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) => LocationResponseModel(
    uuid: json["uuid"],
    name: json["name"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "active": active,
  };
}
