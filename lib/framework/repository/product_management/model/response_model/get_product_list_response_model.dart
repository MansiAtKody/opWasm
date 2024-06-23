// To parse this JSON data, do
//
//     final getProductListResponseModel = getProductListResponseModelFromJson(jsonString);

import 'dart:convert';

GetProductListResponseModel getProductListResponseModelFromJson(String str) => GetProductListResponseModel.fromJson(json.decode(str));

String getProductListResponseModelToJson(GetProductListResponseModel data) => json.encode(data.toJson());

class GetProductListResponseModel {
  int? pageNumber;
  List<GetProductListResponseData>? data;
  bool? hasNextPage;
  int? totalPages;
  bool? hasPreviousPage;
  String? message;
  int? totalCount;
  int? status;

  GetProductListResponseModel({
    this.pageNumber,
    this.data,
    this.hasNextPage,
    this.totalPages,
    this.hasPreviousPage,
    this.message,
    this.totalCount,
    this.status,
  });

  factory GetProductListResponseModel.fromJson(Map<String, dynamic> json) => GetProductListResponseModel(
        pageNumber: json['pageNumber'],
        data: json['data'] == null ? [] : List<GetProductListResponseData>.from(json['data']!.map((x) => GetProductListResponseData.fromJson(x))),
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

class GetProductListResponseData {
  String? uuid;
  // bool? active;
  bool? isAvailable;
  String? image;
  String? imageUrl;
  String? categoryUuid;
  String? categoryName;
  String? subCategoryUuid;
  String? subCategoryName;
  String? productName;
  String? productDescription;
  bool? isExpanded;

  GetProductListResponseData({
    this.uuid,
    // this.active,
    this.isAvailable,
    this.image,
    this.imageUrl,
    this.categoryUuid,
    this.categoryName,
    this.subCategoryUuid,
    this.subCategoryName,
    this.productName,
    this.productDescription,
    this.isExpanded,
  });

  factory GetProductListResponseData.fromJson(Map<String, dynamic> json) => GetProductListResponseData(
        uuid: json['uuid'],
        // active: json['active'],
        isAvailable: json['isAvailable'],
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
        // 'active': active,
        'isAvailable': isAvailable,
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
