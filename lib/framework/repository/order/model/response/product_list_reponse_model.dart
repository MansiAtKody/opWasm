// To parse this JSON data, do
//
//     final productListResponseModel = productListResponseModelFromJson(jsonString);

import 'dart:convert';

ProductListResponseModel productListResponseModelFromJson(String str) => ProductListResponseModel.fromJson(json.decode(str));

String productListResponseModelToJson(ProductListResponseModel data) => json.encode(data.toJson());

class ProductListResponseModel {
  int? pageNumber;
  List<ProductList>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  String? message;
  int? totalCount;
  int? status;

  ProductListResponseModel({
    this.pageNumber,
    this.data,
    this.hasNextPage,
    this.totalPages,
    this.hasPreviousPage,
    this.message,
    this.totalCount,
    this.status,
  });

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) => ProductListResponseModel(
    pageNumber: json['pageNumber'],
    data: json['data'] == null ? [] : List<ProductList>.from(json['data']!.map((x) => ProductList.fromJson(x))),
    hasNextPage: json['hasNextPage'],
    totalPages: json['totalPages'],
    hasPreviousPage: json['hasPreviousPage'],
    message: json['message'],
    totalCount: json['totalCount'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'pageNumber': pageNumber,
    'data': data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    'hasNextPage': hasNextPage,
    'totalPages': totalPages,
    'hasPreviousPage': hasPreviousPage,
    'message': message,
    'totalCount': totalCount,
    'status': status,
  };
}

class ProductList {
  String? uuid;
  bool? active;
  String? image;
  String? imageUrl;
  String? categoryUuid;
  String? categoryName;
  String? subCategoryUuid;
  String? subCategoryName;
  String? productName;
  String? productDescription;

  ProductList({
    this.uuid,
    this.active,
    this.image,
    this.imageUrl,
    this.categoryUuid,
    this.categoryName,
    this.subCategoryUuid,
    this.subCategoryName,
    this.productName,
    this.productDescription,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    uuid: json['uuid'],
    active: json['active'],
    image: json['image'],
    imageUrl: json['imageUrl'],
    categoryUuid: json['categoryUuid'],
    categoryName: json['categoryName'],
    subCategoryUuid: json['subCategoryUuid'],
    subCategoryName: json['subCategoryName'],
    productName: json['productName'],
    productDescription: json['productDescription'],
  );

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'active': active,
    'image': image,
    'imageUrl': imageUrl,
    'categoryUuid': categoryUuid,
    'categoryName': categoryName,
    'subCategoryUuid': subCategoryUuid,
    'subCategoryName': subCategoryName,
    'productName': productName,
    'productDescription': productDescription,
  };
}
