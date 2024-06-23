// To parse this JSON data, do
//
//     final productListRequestModel = productListRequestModelFromJson(jsonString);

import 'dart:convert';

ProductListRequestModel productListRequestModelFromJson(String str) => ProductListRequestModel.fromJson(json.decode(str));

String productListRequestModelToJson(ProductListRequestModel data) => json.encode(data.toJson());

class ProductListRequestModel {
  String? categoryUuid;
  String? subCategoryUuid;
  String? active;
  String? searchKeyWord;

  ProductListRequestModel({
    this.categoryUuid,
    this.subCategoryUuid,
    this.active,
    this.searchKeyWord,
  });

  factory ProductListRequestModel.fromJson(Map<String, dynamic> json) => ProductListRequestModel(
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
