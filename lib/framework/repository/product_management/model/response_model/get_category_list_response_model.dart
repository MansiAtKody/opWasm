// To parse this JSON data, do
//
//     final getCategoryListResponseModel = getCategoryListResponseModelFromJson(jsonString);

import 'dart:convert';

GetCategoryListResponseModel getCategoryListResponseModelFromJson(String str) => GetCategoryListResponseModel.fromJson(json.decode(str));

String getCategoryListResponseModelToJson(GetCategoryListResponseModel data) => json.encode(data.toJson());

class GetCategoryListResponseModel {
  int? pageNumber;
  List<GetCategoryListResponseData>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  int? pageSize;
  String? message;
  int? totalCount;
  int? status;

  GetCategoryListResponseModel({
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

  factory GetCategoryListResponseModel.fromJson(Map<String, dynamic> json) => GetCategoryListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<GetCategoryListResponseData>.from(json["data"]!.map((x) => GetCategoryListResponseData.fromJson(x))),
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

class GetCategoryListResponseData {
  String? uuid;
  String? name;
  bool? active;

  GetCategoryListResponseData({
    this.uuid,
    this.name,
    this.active,
  });

  factory GetCategoryListResponseData.fromJson(Map<String, dynamic> json) => GetCategoryListResponseData(
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
