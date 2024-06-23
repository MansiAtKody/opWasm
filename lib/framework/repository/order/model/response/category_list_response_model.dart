// To parse this JSON data, do
//
//     final categoryListResponseModel = categoryListResponseModelFromJson(jsonString);

import 'dart:convert';

CategoryListResponseModel categoryListResponseModelFromJson(String str) => CategoryListResponseModel.fromJson(json.decode(str));

String categoryListResponseModelToJson(CategoryListResponseModel data) => json.encode(data.toJson());

class CategoryListResponseModel {
  int? pageNumber;
  List<CategoryData>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  int? pageSize;
  String? message;
  int? totalCount;
  int? status;

  CategoryListResponseModel({
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

  factory CategoryListResponseModel.fromJson(Map<String, dynamic> json) => CategoryListResponseModel(
    pageNumber: json["pageNumber"],
    data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
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

class CategoryData {
  String? uuid;
  String? name;
  bool? active;

  CategoryData({
    this.uuid,
    this.name,
    this.active,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
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
