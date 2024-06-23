// To parse this JSON data, do
//
//     final getProductListRequestModel = getProductListRequestModelFromJson(jsonString);

import 'dart:convert';

GetProductListRequestModel getProductListRequestModelFromJson(String str) => GetProductListRequestModel.fromJson(json.decode(str));

String getProductListRequestModelToJson(GetProductListRequestModel data) => json.encode(data.toJson());

class GetProductListRequestModel {
  String? categoryUuid;
  String? subCategoryUuid;
  String? active;
  String? searchKeyWord;

  GetProductListRequestModel({
    this.categoryUuid,
    this.subCategoryUuid,
    this.active,
    this.searchKeyWord,
  });

  factory GetProductListRequestModel.fromJson(Map<String, dynamic> json) => GetProductListRequestModel(
    categoryUuid: json["categoryUuid"],
    subCategoryUuid: json["subCategoryUuid"],
    active: json["active"],
    searchKeyWord: json["searchKeyWord"],
  );

  Map<String, dynamic> toJson() => {
    "categoryUuid": categoryUuid,
    "subCategoryUuid": subCategoryUuid,
    "active": active,
    "searchKeyWord": searchKeyWord,
  };
}
